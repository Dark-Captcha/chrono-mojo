# NaturalDate — a small, explicit parser for common natural-language date expressions,
# resolved relative to a reference DateTime. The grammar is deliberately bounded (no
# free-form guessing): anything outside it raises.
#
# Grammar (case-insensitive, English):
#   now                         -> the reference instant, unchanged
#   today | tomorrow | yesterday-> that calendar date at 00:00:00
#   in <N> <unit>               -> reference + N units (future)
#   <N> <unit> ago              -> reference - N units (past)
#   next <weekday>              -> the next such weekday after the reference date, 00:00
#   last <weekday>              -> the previous such weekday before the reference date
# unit is a TimeUnit (typed enum). Weekday names come straight from the Weekday enum
# — full ("Monday") or abbreviated ("Mon").
#
# Facets: tier T1 (breadth) | safety sound (raises on anything off-grammar) | quantum n/a.
# Honesty: heuristic by nature, so there is no external oracle — KAT-verified against a
# fixed reference. Unit dispatch lives ONCE inside TimeUnit (parse + apply); weekday
# vocabulary comes from the Weekday enum — neither is scattered across callers.

from chrono.datetime import DateTime
from chrono.enums import Weekday
from chrono.duration import Duration
from chrono.span import Span
from chrono.time import Time
from chrono._core.units import (
    SECONDS_PER_MINUTE,
    SECONDS_PER_HOUR,
    SECONDS_PER_DAY,
    DAYS_PER_WEEK,
)


struct TimeUnit(Equatable, ImplicitlyCopyable, Movable):
    """A unit of time the natural-language parser shifts a moment by. Holds either
    an exact `seconds`-per-unit (SECOND..WEEK) or a calendar `months`/`years` count
    (MONTH, YEAR); the convention is that exactly one of the three fields is non-zero.
    `apply()` dispatches on that, so callers never branch on the unit kind."""

    var _seconds: Int64
    var _months: Int
    var _years: Int

    @always_inline
    def __init__(
        out self, *, seconds: Int64 = 0, months: Int = 0, years: Int = 0
    ):
        self._seconds = seconds
        self._months = months
        self._years = years

    comptime SECOND = TimeUnit(seconds=1)
    comptime MINUTE = TimeUnit(seconds=Int64(SECONDS_PER_MINUTE))
    comptime HOUR = TimeUnit(seconds=Int64(SECONDS_PER_HOUR))
    comptime DAY = TimeUnit(seconds=Int64(SECONDS_PER_DAY))
    comptime WEEK = TimeUnit(seconds=Int64(SECONDS_PER_DAY * DAYS_PER_WEEK))
    comptime MONTH = TimeUnit(months=1)
    comptime YEAR = TimeUnit(years=1)

    @staticmethod
    def parse(name: String) raises -> Self:
        """The unit named by `name` (lower-case, singular or plural form, English).
        One home for the lookup — callers do not duplicate this if/elif."""
        if name == "second" or name == "seconds":
            return Self.SECOND
        if name == "minute" or name == "minutes":
            return Self.MINUTE
        if name == "hour" or name == "hours":
            return Self.HOUR
        if name == "day" or name == "days":
            return Self.DAY
        if name == "week" or name == "weeks":
            return Self.WEEK
        if name == "month" or name == "months":
            return Self.MONTH
        if name == "year" or name == "years":
            return Self.YEAR
        raise Error("chrono.natural: unknown unit '" + name + "'")

    def apply(self, moment: DateTime, count: Int) raises -> DateTime:
        """Shift `moment` by `count` of this unit. Duration units add an exact
        Duration; calendar units add a Span (with end-of-month clamping)."""
        if self._seconds != 0:
            return moment + Duration.from_seconds(Int64(count) * self._seconds)
        return moment.plus_span(
            Span(years=count * self._years, months=count * self._months)
        )

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return (
            self._seconds == other._seconds
            and self._months == other._months
            and self._years == other._years
        )

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)


def _parse_count(token: String) raises -> Int:
    """Parse a strictly-positive integer count from a natural-date token (the N
    in "in N units" / "N units ago"). The grammar bounds N >= 1 — the polarity
    is carried by the marker word ("in" / "ago"), and a leading sign on N would
    let "in -3 days" mean "3 days ago" silently (two ways to spell one thing).
    Zero is rejected for the same reason: `"in 0 days"` is a no-op pretending
    to be a shift."""
    var value: Int
    try:
        value = Int(token)
    except:
        raise Error("chrono.natural: '" + token + "' is not a number")
    if value < 1:
        raise Error("chrono.natural: count must be >= 1, got " + String(value))
    return value


def _resolve_weekday(token: String) raises -> Weekday:
    """Token (already lower-case) -> Weekday. Matches against English weekday
    names (full + 3-letter abbreviation) taken from the Weekday enum, so the
    English vocabulary lives in exactly one place."""
    for iso in range(1, 8):
        var full = String(Weekday(raw=UInt8(iso)).name())
        if token == full.lower() or token == String(full[byte=0:3]).lower():
            return Weekday(raw=UInt8(iso))
    raise Error("chrono.natural: unknown weekday '" + token + "'")


struct NaturalDate:
    @staticmethod
    def parse(text: String, reference: DateTime) raises -> DateTime:
        """Parse English natural-language date expressions against `reference`.
        Branches dispatch on marker tokens (`now`/`next`/`in`/`ago`), not token
        position, so the grammar stays explicit and bounded."""
        var lowered = text.lower()  # kept alive: `tokens` are slices into it
        var tokens = lowered.split()
        var count = len(tokens)
        if count == 0:
            raise Error("chrono.natural: empty input")

        # one-word now / today / tomorrow / yesterday
        if count == 1:
            var word = tokens[0]
            if word == "now":
                return reference
            if word == "today":
                return DateTime.combine(reference.date(), Time.MIDNIGHT)
            if word == "tomorrow":
                return DateTime.combine(
                    reference.date().plus_days(1), Time.MIDNIGHT
                )
            if word == "yesterday":
                return DateTime.combine(
                    reference.date().minus_days(1), Time.MIDNIGHT
                )
            raise Error("chrono.natural: cannot parse '" + text + "'")

        # next/last <weekday>
        if (tokens[0] == "next" or tokens[0] == "last") and count == 2:
            var target = _resolve_weekday(String(tokens[1])).iso_number()
            var current = reference.date().weekday().iso_number()
            if tokens[0] == "next":
                # smallest n in 1..DAYS_PER_WEEK with current+n on the target weekday
                var ahead = (
                    (target - current + DAYS_PER_WEEK - 1) % DAYS_PER_WEEK
                ) + 1
                return DateTime.combine(
                    reference.date().plus_days(ahead), Time.MIDNIGHT
                )
            var behind = (
                (current - target + DAYS_PER_WEEK - 1) % DAYS_PER_WEEK
            ) + 1
            return DateTime.combine(
                reference.date().minus_days(behind), Time.MIDNIGHT
            )

        # 3-token shifts: "in N <unit>" / "<N> <unit> ago" — dispatch is one line,
        # TimeUnit owns both the name lookup and the apply.
        if count == 3:
            if tokens[0] == "in":
                return TimeUnit.parse(String(tokens[2])).apply(
                    reference, _parse_count(String(tokens[1]))
                )
            if tokens[2] == "ago":
                return TimeUnit.parse(String(tokens[1])).apply(
                    reference, -_parse_count(String(tokens[0]))
                )

        raise Error("chrono.natural: cannot parse '" + text + "'")
