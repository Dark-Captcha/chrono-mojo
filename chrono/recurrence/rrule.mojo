# RecurrenceRule — RFC 5545 recurrence rules (the RRULE part). Parses a rule string
# ("FREQ=WEEKLY;BYDAY=MO,WE,FR;COUNT=6") and, from a DTSTART, expands the recurrence
# set in chronological order, carrying DTSTART's time of day.
#
# Supported: FREQ = DAILY | WEEKLY | MONTHLY | YEARLY, INTERVAL, COUNT, UNTIL, BYMONTH,
# BYMONTHDAY (negative = from month end), BYDAY (with an optional ordinal, e.g. 2TU,
# -1SU), WKST. Sub-day frequencies (HOURLY/MINUTELY/SECONDLY) and the BYxxx forms not
# listed (BYYEARDAY, BYWEEKNO, BYSETPOS, BYHOUR/…) are out of scope and raise on parse.
#
# Facets: tier T1 (breadth) | safety sound (bounded by COUNT/UNTIL/limit) | quantum n/a.
# Honesty: from RFC 5545; the supported subset is verified differential vs
# python-dateutil's rrule. Occurrences are the rule matches at or after DTSTART
# (DTSTART is not force-included unless it matches), exactly as dateutil yields them.

from std.collections.inline_array import InlineArray

from chrono._core.civil import (
    days_since_epoch_from_date,
    date_from_days_since_epoch,
    iso_weekday_from_days_since_epoch,
    days_in_month,
    YearMonthDay,
)
from chrono.date import Date
from chrono.datetime import DateTime
from chrono.enums import Weekday
from chrono._internal.scanner import Scanner
from chrono._internal import charset
from chrono._core.units import DAYS_PER_WEEK, MONTHS_PER_YEAR

comptime _DEFAULT_LIMIT = 10000  # safety cap for an unbounded rule (no COUNT/UNTIL)
comptime _MAX_EMPTY_PERIODS = 4000  # give up if this many periods yield nothing

comptime _FREQUENCY_NAMES: InlineArray[StaticString, 4] = [
    "DAILY",
    "WEEKLY",
    "MONTHLY",
    "YEARLY",
]


struct Frequency(Equatable, ImplicitlyCopyable, Movable):
    """RFC 5545 RRULE FREQ value. Sub-day frequencies (HOURLY/MINUTELY/SECONDLY)
    are deliberately not represented — they raise on `parse`."""

    var _value: UInt8

    @always_inline
    def __init__(out self, *, raw: UInt8):
        """Internal: skip validation. Callers must guarantee `raw` is a
        declared FREQ discriminant (0..3)."""
        self._value = raw

    comptime DAILY = Frequency(raw=0)
    comptime WEEKLY = Frequency(raw=1)
    comptime MONTHLY = Frequency(raw=2)
    comptime YEARLY = Frequency(raw=3)

    @staticmethod
    def parse(name: String) raises -> Self:
        """The Frequency named by `name` (the RFC 5545 keyword, upper-case). One
        home for the name lookup so callers don't repeat it."""
        for i in range(4):
            if name == String(_FREQUENCY_NAMES[i]):
                return Frequency(raw=UInt8(i))
        raise Error(
            "chrono.rrule: unsupported FREQ '"
            + name
            + "' (sub-day not supported)"
        )

    @always_inline
    def name(self) -> StaticString:
        return _FREQUENCY_NAMES[Int(self._value)]

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._value == other._value

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return self._value != other._value


struct WeekdayRule(ImplicitlyCopyable, Movable):
    """A BYDAY entry: a typed Weekday + an ordinal (0 = every occurrence in the
    period; +n = the nth; -n = the nth from the end).

    Per RFC 5545 §3.3.10, the ordinal range is {-53..-1, 0, 1..53}: an ordinal
    of ±54+ would silently never match the period-expansion loop, hiding a
    typo'd rule. Validated at construction so garbage-in fails fast."""

    var weekday: Weekday
    var ordinal: Int

    def __init__(out self, weekday: Weekday, ordinal: Int) raises:
        if ordinal < -53 or ordinal > 53:
            raise Error(
                "chrono.rrule: BYDAY ordinal out of RFC 5545 range (-53..53),"
                " got " + String(ordinal)
            )
        self.weekday = weekday
        self.ordinal = ordinal


def _to_int(s: String) raises -> Int:
    """Parse a signed integer (BYDAY ordinals and negative BYMONTHDAY use a sign).
    Bounded at 18 decimal digits to fit safely in Int64 without an overflow check
    on the multiply — every RRULE field has a domain max well under 10^9, so this
    is a sanity ceiling, not a value-domain bound."""
    var b = s.as_bytes()
    var n = len(b)
    if n == 0:
        raise Error("chrono.rrule: empty number in RRULE value")
    var i = 0
    var sign = 1
    if Int(b[0]) == charset.PLUS or Int(b[0]) == charset.MINUS:
        if Int(b[0]) == charset.MINUS:
            sign = -1
        i = 1
    var value = 0
    var digits = 0
    while i < n:
        if not charset.is_digit(Int(b[i])):
            raise Error("chrono.rrule: bad digit in number '" + s + "'")
        if digits >= 18:
            raise Error(
                "chrono.rrule: number '" + s + "' is too large (>18 digits)"
            )
        value = value * 10 + (Int(b[i]) - charset.DIGIT_ZERO)
        digits += 1
        i += 1
    if digits == 0:
        raise Error("chrono.rrule: no digits in number '" + s + "'")
    return sign * value


def _weekday_from_token(token: String) raises -> Weekday:
    """RFC 5545 weekday token (SU/MO/TU/WE/TH/FR/SA) -> Weekday. Data-driven over
    the Weekday enum: the 2-letter abbreviation is the first two letters of the
    English name, upper-cased (Monday -> MO, …, Sunday -> SU). One source of truth."""
    for iso in range(1, 8):
        if token == String(Weekday(raw=UInt8(iso)).name()[byte=0:2]).upper():
            return Weekday(raw=UInt8(iso))
    raise Error("chrono.rrule: bad weekday token '" + token + "'")


struct RecurrenceRule(Copyable, Movable):
    var frequency: Frequency
    var interval: Int
    var count: Int  # 0 = no count limit
    var has_until: Bool
    var until: DateTime
    var by_month: List[Int]
    var by_month_day: List[Int]  # negative = counted from the month end
    var by_weekday: List[WeekdayRule]
    var week_start: Weekday  # WKST anchor (Monday by default per RFC 5545)

    def __init__(
        out self,
        frequency: Frequency,
        interval: Int,
        count: Int,
        has_until: Bool,
        until: DateTime,
        var by_month: List[Int],
        var by_month_day: List[Int],
        var by_weekday: List[WeekdayRule],
        week_start: Weekday,
    ):
        self.frequency = frequency
        self.interval = interval
        self.count = count
        self.has_until = has_until
        self.until = until
        self.by_month = by_month^
        self.by_month_day = by_month_day^
        self.by_weekday = by_weekday^
        self.week_start = week_start

    @staticmethod
    def parse(text: String) raises -> Self:
        var frequency = Frequency.DAILY
        var saw_freq = False
        var interval = 1
        var count = 0
        var has_until = False
        var until = DateTime(1970, 1, 1, 0, 0, 0)
        var by_month = List[Int]()
        var by_month_day = List[Int]()
        var by_weekday = List[WeekdayRule]()
        var week_start = Weekday.MONDAY  # RFC 5545 default

        for part in text.split(";"):
            if part.byte_length() == 0:
                continue
            var kv = part.split("=")
            if len(kv) != 2:
                raise Error(
                    "chrono.rrule: malformed component '" + String(part) + "'"
                )
            # RFC 5545 §3.3.10: parameter NAMES are ABNF tokens (case-insensitive);
            # values follow each parameter's own grammar (FREQ keywords + WKST/BYDAY
            # tokens are already upper-case by the spec, so we don't touch values).
            var key = String(kv[0]).upper()
            var value = String(kv[1])
            if key == "FREQ":
                saw_freq = True
                frequency = Frequency.parse(value)
            elif key == "INTERVAL":
                interval = _to_int(value)
                if interval < 1:
                    raise Error(
                        "chrono.rrule: INTERVAL must be >= 1, got "
                        + String(interval)
                    )
                # An INTERVAL of millions multiplied by `period` overflows the
                # int arithmetic in _yearly/_monthly_candidates and produces
                # wildly wrong dates. 9999 covers every reasonable RRULE.
                if interval > 9999:
                    raise Error(
                        "chrono.rrule: INTERVAL > 9999 is unsupported, got "
                        + String(interval)
                    )
            elif key == "COUNT":
                count = _to_int(value)
                if count < 1:
                    raise Error(
                        "chrono.rrule: COUNT must be >= 1 (RFC 5545 §3.3.10), got "
                        + String(count)
                    )
            elif key == "UNTIL":
                until = _parse_until(value)
                has_until = True
            elif key == "WKST":
                week_start = _weekday_from_token(value)
            elif key == "BYMONTH":
                # RFC 5545 §3.3.11: BYMONTH values are in 1..12. Raise at parse
                # time on out-of-range — silently appending 13 or 0 would just
                # make the rule produce zero occurrences forever.
                for month in value.split(","):
                    var m = _to_int(String(month))
                    if m < 1 or m > 12:
                        raise Error(
                            "chrono.rrule: BYMONTH out of range (1..12), got "
                            + String(m)
                        )
                    by_month.append(m)
            elif key == "BYMONTHDAY":
                # RFC 5545 §3.3.10: BYMONTHDAY values are in {-31..-1, 1..31};
                # 0 is forbidden, and any |d| > 31 can never match a month. Raise
                # at parse time so a typo'd rule fails fast instead of silently
                # producing no occurrences.
                for day in value.split(","):
                    var d = _to_int(String(day))
                    if d == 0 or d < -31 or d > 31:
                        raise Error(
                            "chrono.rrule: BYMONTHDAY out of RFC 5545 range"
                            " (-31..-1, 1..31), got " + String(d)
                        )
                    by_month_day.append(d)
            elif key == "BYDAY":
                for token in value.split(","):
                    by_weekday.append(_parse_weekday_rule(String(token)))
            elif (
                key == "BYSETPOS"
                or key == "BYWEEKNO"
                or key == "BYYEARDAY"
                or key == "BYHOUR"
                or key == "BYMINUTE"
                or key == "BYSECOND"
            ):
                # Out-of-scope BY rules — chrono raises rather than silently
                # dropping them, so a rule that depends on them produces a
                # diagnostic instead of wrong occurrences.
                raise Error(
                    "chrono.rrule: "
                    + key
                    + " is out of scope (supported BY rules:"
                    " BYMONTH, BYMONTHDAY, BYDAY)"
                )
            else:
                raise Error("chrono.rrule: unsupported component '" + key + "'")

        if not saw_freq:
            raise Error("chrono.rrule: FREQ is required")
        # RFC 5545 §3.3.10: COUNT and UNTIL MUST NOT both appear in the same rule.
        if count > 0 and has_until:
            raise Error(
                "chrono.rrule: COUNT and UNTIL MUST NOT both appear (RFC 5545 §3.3.10)"
            )
        # RFC 5545 §3.3.10: an ordinal-prefixed BYDAY (e.g. `2TU`) is valid ONLY with
        # FREQ=MONTHLY or YEARLY. With DAILY or WEEKLY it MUST NOT carry a numeric
        # value; we raise instead of silently dropping the ordinal.
        if frequency == Frequency.DAILY or frequency == Frequency.WEEKLY:
            for i in range(len(by_weekday)):
                if by_weekday[i].ordinal != 0:
                    raise Error(
                        "chrono.rrule: BYDAY ordinal is only valid with FREQ=MONTHLY or YEARLY"
                    )
        return Self(
            frequency,
            interval,
            count,
            has_until,
            until,
            by_month^,
            by_month_day^,
            by_weekday^,
            week_start,
        )

    def occurrences(
        self, dtstart: DateTime, limit: Int = _DEFAULT_LIMIT
    ) raises -> List[DateTime]:
        """The recurrence set from `dtstart`, in order. The yielded count is the
        minimum of `limit` and COUNT (if set); UNTIL stops emission earlier.
        `limit` is the hard ceiling — a hostile RRULE with COUNT=2_000_000_000
        cannot exceed it.

        If the rule sets neither COUNT nor UNTIL AND the `limit` is reached
        before exhaustion, this raises rather than silently returning a
        truncated list — the caller cannot tell those two cases apart by the
        returned length alone, so we surface the cliff."""
        var out = List[DateTime]()
        var start_day = dtstart.date().days_since_epoch()
        var start_ymd = dtstart.date().year_month_day()
        var time = dtstart.time()
        # Always cap by the caller's `limit`. COUNT only tightens it — it can
        # never widen the bound (this is the DoS-defense invariant).
        var emit_cap = limit
        if self.count > 0 and self.count < emit_cap:
            emit_cap = self.count
        var unbounded = self.count == 0 and not self.has_until

        var period = 0
        var empty_periods = 0
        while len(out) < emit_cap:
            var candidates = self._period_candidates(
                start_day, start_ymd, period
            )
            if len(candidates) == 0:
                # tolerate empty periods (e.g. YEARLY on Feb 29 skips common years),
                # but give up if the rule can never emit again
                empty_periods += 1
                if empty_periods > _MAX_EMPTY_PERIODS:
                    break
                period += 1
                continue
            empty_periods = 0
            for c in range(len(candidates)):
                var day = candidates[c]
                if day < start_day:
                    continue
                var occurrence = DateTime.combine(
                    Date(days_since_epoch=Int32(day)), time
                )
                if self.has_until and occurrence > self.until:
                    return out^
                out.append(occurrence)
                if len(out) >= emit_cap:
                    if unbounded:
                        raise Error(
                            "chrono.rrule: unbounded rule hit limit "
                            + String(limit)
                            + " — pass a larger `limit` or set COUNT/UNTIL"
                        )
                    return out^
            period += 1
        return out^

    def _period_candidates(
        self, start_day: Int, start_ymd: YearMonthDay, period: Int
    ) raises -> List[Int]:
        """Sorted, de-duplicated epoch-days produced by the BY rules in `period`."""
        if self.frequency == Frequency.DAILY:
            return self._daily_candidates(start_day, period)
        if self.frequency == Frequency.WEEKLY:
            return self._weekly_candidates(start_day, period)
        if self.frequency == Frequency.MONTHLY:
            return self._monthly_candidates(start_ymd, period)
        return self._yearly_candidates(start_ymd, period)

    def _daily_candidates(
        self, start_day: Int, period: Int
    ) raises -> List[Int]:
        var out = List[Int]()
        var day = start_day + period * self.interval
        var ymd = date_from_days_since_epoch(day)
        if not self._month_allowed(ymd.month):
            return out^
        if not self._daily_monthday_allowed(ymd):
            return out^
        if not self._daily_weekday_allowed(day):
            return out^
        out.append(day)
        return out^

    def _weekly_candidates(
        self, start_day: Int, period: Int
    ) raises -> List[Int]:
        var aligned = start_day - (
            (
                iso_weekday_from_days_since_epoch(start_day)
                - self.week_start.iso_number()
                + DAYS_PER_WEEK
            )
            % DAYS_PER_WEEK
        )
        var week = aligned + period * self.interval * DAYS_PER_WEEK
        var wanted = self._weekly_weekdays(start_day)
        var out = List[Int]()
        for offset in range(7):
            var day = week + offset
            var ymd = date_from_days_since_epoch(day)
            if not self._month_allowed(ymd.month):
                continue
            if _contains(wanted, iso_weekday_from_days_since_epoch(day)):
                _insert_sorted(out, day)
        return out^

    def _monthly_candidates(
        self, start_ymd: YearMonthDay, period: Int
    ) raises -> List[Int]:
        var total = (
            start_ymd.year * MONTHS_PER_YEAR
            + (start_ymd.month - 1)
            + period * self.interval
        )
        var year = total // MONTHS_PER_YEAR
        var month = total % MONTHS_PER_YEAR + 1
        var out = List[Int]()
        if not self._month_allowed(month):
            return out^
        self._collect_month(year, month, start_ymd.day, out)
        return out^

    def _yearly_candidates(
        self, start_ymd: YearMonthDay, period: Int
    ) raises -> List[Int]:
        var year = start_ymd.year + period * self.interval
        var out = List[Int]()
        if len(self.by_month) > 0:
            for i in range(len(self.by_month)):
                self._collect_month(year, self.by_month[i], start_ymd.day, out)
        else:
            self._collect_month(year, start_ymd.month, start_ymd.day, out)
        return out^

    def _collect_month(
        self, year: Int, month: Int, default_day: Int, mut out: List[Int]
    ) raises:
        """Append the in-month occurrence days from BYMONTHDAY / BYDAY (or the
        default day-of-month when neither applies), keeping `out` sorted and
        de-duplicated.

        When BOTH BYMONTHDAY and BYDAY are set, BYDAY shifts from EXPAND to
        LIMIT role (RFC 5545 §3.3.10 Note 1 for MONTHLY, Note 2 for YEARLY):
        only days from BYMONTHDAY whose weekday also appears in BYDAY are
        kept, and the BYDAY ordinal is meaningless in this role. With only
        one of the two, the rule expands normally."""
        var length = days_in_month(year, month)
        var has_md = len(self.by_month_day) > 0
        var has_bd = len(self.by_weekday) > 0
        if not has_md and not has_bd:
            if default_day <= length:
                _insert_sorted(
                    out, days_since_epoch_from_date(year, month, default_day)
                )
            return
        if has_md and has_bd:
            for i in range(len(self.by_month_day)):
                var d = self.by_month_day[i]
                var day_of_month = d if d > 0 else length + 1 + d
                if day_of_month < 1 or day_of_month > length:
                    continue
                var epoch_day = days_since_epoch_from_date(
                    year, month, day_of_month
                )
                var iso_dow = iso_weekday_from_days_since_epoch(epoch_day)
                for k in range(len(self.by_weekday)):
                    if self.by_weekday[k].weekday.iso_number() == iso_dow:
                        _insert_sorted(out, epoch_day)
                        break
            return
        for i in range(len(self.by_month_day)):
            var d = self.by_month_day[i]
            var day_of_month = d if d > 0 else length + 1 + d
            if day_of_month >= 1 and day_of_month <= length:
                _insert_sorted(
                    out, days_since_epoch_from_date(year, month, day_of_month)
                )
        for i in range(len(self.by_weekday)):
            var rule = self.by_weekday[i]
            self._collect_weekday_in_month(year, month, rule, out)

    def _collect_weekday_in_month(
        self, year: Int, month: Int, rule: WeekdayRule, mut out: List[Int]
    ) raises:
        var length = days_in_month(year, month)
        var first_day = days_since_epoch_from_date(year, month, 1)
        var first_iso = iso_weekday_from_days_since_epoch(first_day)
        var first_match = 1 + (
            (rule.weekday.iso_number() - first_iso + DAYS_PER_WEEK)
            % DAYS_PER_WEEK
        )  # 1..7
        # all matching days-of-month for this weekday
        var matches = List[Int]()
        var dom = first_match
        while dom <= length:
            matches.append(dom)
            dom += 7
        if rule.ordinal == 0:
            for k in range(len(matches)):
                _insert_sorted(
                    out, days_since_epoch_from_date(year, month, matches[k])
                )
        elif rule.ordinal > 0:
            if rule.ordinal <= len(matches):
                _insert_sorted(
                    out,
                    days_since_epoch_from_date(
                        year, month, matches[rule.ordinal - 1]
                    ),
                )
        else:
            var index = len(matches) + rule.ordinal  # -1 -> last
            if index >= 0:
                _insert_sorted(
                    out, days_since_epoch_from_date(year, month, matches[index])
                )

    def _month_allowed(self, month: Int) -> Bool:
        if len(self.by_month) == 0:
            return True
        return _contains(self.by_month, month)

    def _daily_monthday_allowed(self, ymd: YearMonthDay) -> Bool:
        if len(self.by_month_day) == 0:
            return True
        var length = days_in_month(ymd.year, ymd.month)
        for i in range(len(self.by_month_day)):
            var d = self.by_month_day[i]
            var day_of_month = d if d > 0 else length + 1 + d
            if day_of_month == ymd.day:
                return True
        return False

    def _daily_weekday_allowed(self, day: Int) -> Bool:
        if len(self.by_weekday) == 0:
            return True
        var iso = iso_weekday_from_days_since_epoch(day)
        for i in range(len(self.by_weekday)):
            if self.by_weekday[i].weekday.iso_number() == iso:
                return True
        return False

    def _weekly_weekdays(self, start_day: Int) -> List[Int]:
        var out = List[Int]()
        if len(self.by_weekday) == 0:
            out.append(iso_weekday_from_days_since_epoch(start_day))
        else:
            for i in range(len(self.by_weekday)):
                out.append(self.by_weekday[i].weekday.iso_number())
        return out^


def _parse_until(value: String) raises -> DateTime:
    """Parse a basic-format UNTIL: YYYYMMDD or YYYYMMDDTHHMMSS, optional trailing Z."""
    var scanner = Scanner(value)
    var year = scanner.take_int(4)
    var month = scanner.take_int(2)
    var day = scanner.take_int(2)
    var hour = 0
    var minute = 0
    var second = 0
    if scanner.accept("T"):
        hour = scanner.take_int(2)
        minute = scanner.take_int(2)
        second = scanner.take_int(2)
    _ = scanner.accept("Z") or scanner.accept("z")  # optional UTC marker
    if not scanner.is_at_end():
        raise Error("chrono.rrule: trailing data in UNTIL")
    return DateTime(year, month, day, hour, minute, second)


def _parse_weekday_rule(token: String) raises -> WeekdayRule:
    """A BYDAY token: an optional signed ordinal then a 2-letter weekday (2TU, -1SU,
    MO)."""
    var n = token.byte_length()
    if n < 2:
        raise Error("chrono.rrule: bad BYDAY token")
    var split = n - 2  # the weekday is the last two characters
    var weekday = _weekday_from_token(String(token[byte=split:n]))
    var ordinal = 0
    if split > 0:
        ordinal = _to_int(String(token[byte=0:split]))
    return WeekdayRule(weekday, ordinal)


def _contains(values: List[Int], target: Int) -> Bool:
    for i in range(len(values)):
        if values[i] == target:
            return True
    return False


def _insert_sorted(mut values: List[Int], value: Int):
    """Insert keeping ascending order; ignore duplicates (BY rules can overlap)."""
    for i in range(len(values)):
        if values[i] == value:
            return
        if values[i] > value:
            values.insert(i, value)
            return
    values.append(value)
