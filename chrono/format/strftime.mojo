# Strftime — format and parse a DateTime against a strftime-style pattern (the
# common C89 directive subset). The datetime is naive, so %z/%Z (zone) are not
# supported; an unknown directive raises (no silent passthrough). %A/%a/%B/%b
# names come straight from the Weekday / Month enums (English / C locale).
#
# Supported: %Y %y %m %d %H %I %M %S %j %p %A %a %B %b %%
# `parse` accepts the same set EXCEPT %j (day-of-year would require a multi-pass
# parser to recover month + day from the year, which the single-pass cursor here
# can't do cleanly).
#
# Defects this implementation refuses to ship (the obvious C-strptime traps):
#   * %a / %A parsed weekday MUST match the date — parsing "Mon 15 Jun 2026"
#     (a Monday is correct) succeeds; "Tue 15 Jun 2026" raises.
#   * %I (12-hour) without %p raises — the AM/PM is required to disambiguate.
#   * %Y is the four-digit year, so format rejects year < 0 or > 9999 instead
#     of producing something like "0-44".
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: from spec (C89 directives). KAT/differential vs Python
# `datetime.strftime` for format; symmetric round-trip KAT for parse.

from chrono.datetime import DateTime
from chrono.enums import Weekday, Month
from chrono._internal.text import pad, range_error
from chrono._internal.scanner import Scanner
from chrono._internal import charset


comptime _PERCENT = ord("%")


struct Strftime:
    @staticmethod
    def format(datetime: DateTime, pattern: String) raises -> String:
        """Format with the English (C/POSIX) month and weekday names taken
        directly from the Weekday and Month enums. Year must be 0..9999 (the
        %Y / %y output is fixed-width, and a negative year would produce
        nonsense like "0-44")."""
        var year = datetime.year()
        if year < 0 or year > 9999:
            raise range_error("Strftime", "year", year, 0, 9999)
        var b = pattern.as_bytes()
        var n = len(b)
        var out = String("")
        var i = 0
        while i < n:
            if Int(b[i]) == _PERCENT and i + 1 < n:
                var directive = Int(b[i + 1])
                out += _format_directive(directive, datetime, year, i)
                i += 2
            elif Int(b[i]) == _PERCENT:  # a trailing '%' with no directive
                out += "%"
                i += 1
            else:  # copy a whole literal run at once (not byte by byte)
                var literal_start = i
                while i < n and Int(b[i]) != _PERCENT:
                    i += 1
                out += pattern[byte=literal_start:i]
        return out

    @staticmethod
    def parse(text: String, pattern: String) raises -> DateTime:
        """Parse `text` against the strftime `pattern`, return a DateTime.

        Symmetric to `format` over the same directive set, with one
        exception: %j (day-of-year) is not accepted by parse because
        single-pass cursoring can't recover (month, day) without already
        knowing the year. If the pattern is missing a field, the default
        is Unix epoch — year 1970, month 1, day 1, hour/minute/second 0.

        Conflict resolution: last-write-wins. If both %H and %I appear,
        the later directive's value is used; if %I is the source, %p
        (AM/PM) is REQUIRED to convert to 24-hour form (silently assuming
        AM would let "12:00" mean midnight). If both %m and %B/%b appear,
        the later value wins. A parsed weekday (%a/%A) must match the
        resolved date; trailing input after the pattern is exhausted
        raises."""
        var scanner = Scanner(text)
        var state = _ParseState()
        var pattern_bytes = pattern.as_bytes()
        var pn = len(pattern_bytes)

        var j: Int = 0
        while j < pn:
            if Int(pattern_bytes[j]) == _PERCENT and j + 1 < pn:
                _consume_directive(Int(pattern_bytes[j + 1]), scanner, state, j)
                j += 2
            elif Int(pattern_bytes[j]) == _PERCENT:
                # trailing '%' with no directive — match a literal '%'
                scanner.expect("%")
                j += 1
            else:
                # literal pattern byte — must match the next input byte
                var pattern_char = String(pattern[byte = j : j + 1])
                scanner.expect(pattern_char)
                j += 1

        if not scanner.is_at_end():
            raise Error(
                "chrono.Strftime: trailing input at position "
                + String(scanner.position())
            )

        return state.into_datetime()


@always_inline
def _format_directive(
    directive: Int, datetime: DateTime, year: Int, position: Int
) raises -> String:
    """One directive's formatted output. Year is already validated 0..9999."""
    if directive == ord("Y"):
        return pad(year, 4)
    if directive == ord("y"):
        return pad(year % 100, 2)
    if directive == ord("m"):
        return pad(datetime.month().number(), 2)
    if directive == ord("d"):
        return pad(datetime.day(), 2)
    if directive == ord("H"):
        return pad(datetime.hour(), 2)
    if directive == ord("M"):
        return pad(datetime.minute(), 2)
    if directive == ord("S"):
        return pad(datetime.second(), 2)
    if directive == ord("j"):
        return pad(datetime.date().day_of_year(), 3)
    if directive == ord("A"):
        return String(datetime.weekday().name())
    if directive == ord("a"):
        return String(String(datetime.weekday().name())[byte=0:3])
    if directive == ord("B"):
        return String(datetime.month().name())
    if directive == ord("b"):
        return String(String(datetime.month().name())[byte=0:3])
    if directive == ord("I"):
        var hour12 = datetime.hour() % 12
        return pad(12 if hour12 == 0 else hour12, 2)
    if directive == ord("p"):
        return "PM" if datetime.hour() >= 12 else "AM"
    if directive == _PERCENT:
        return "%"
    raise Error(
        "chrono.Strftime: unsupported directive '%"
        + chr(directive)
        + "' at pattern position "
        + String(position)
    )


struct _ParseState(Copyable, Movable):
    """Field accumulator for `Strftime.parse`. Carries the parsed values plus a
    couple of flags that detect the strptime traps (`%I` without `%p`, weekday
    label mismatching the resolved date)."""

    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var minute: Int
    var second: Int
    var hour_from_12: Bool  # last hour source was %I
    var saw_period: Bool  # %p was provided
    var is_pm: Bool
    var parsed_weekday: Int  # 0 = unspecified, otherwise 1..7 (iso)

    def __init__(out self):
        self.year = 1970
        self.month = 1
        self.day = 1
        self.hour = 0
        self.minute = 0
        self.second = 0
        self.hour_from_12 = False
        self.saw_period = False
        self.is_pm = False
        self.parsed_weekday = 0

    def into_datetime(self) raises -> DateTime:
        var hour = self.hour
        if self.hour_from_12:
            if hour < 1 or hour > 12:
                raise range_error("Strftime", "%I hour", hour, 1, 12)
            if not self.saw_period:
                raise Error(
                    "chrono.Strftime: %I (12-hour clock) requires %p (AM/PM)"
                    " — silently treating 12 as midnight would be wrong"
                )
            var h = 0 if hour == 12 else hour
            hour = h + 12 if self.is_pm else h
        var datetime = DateTime(
            self.year,
            self.month,
            self.day,
            hour,
            self.minute,
            self.second,
        )
        if self.parsed_weekday != 0:
            var actual = datetime.weekday().iso_number()
            if actual != self.parsed_weekday:
                raise Error(
                    "chrono.Strftime: weekday label '"
                    + String(Weekday(raw=UInt8(self.parsed_weekday)).name())
                    + "' disagrees with date "
                    + String(self.year)
                    + "-"
                    + pad(self.month, 2)
                    + "-"
                    + pad(self.day, 2)
                    + " (a "
                    + String(Weekday(raw=UInt8(actual)).name())
                    + ")"
                )
        return datetime


def _consume_directive(
    directive: Int, mut scanner: Scanner, mut state: _ParseState, position: Int
) raises:
    """Single dispatch for parse — keeps the `parse` body short and the trap
    handling (12-hour clock, weekday verify) in one place via `state`."""
    if directive == ord("Y"):
        state.year = scanner.take_int(4)
    elif directive == ord("y"):
        var two = scanner.take_int(2)
        # RFC 5280 §4.1.2.5.1 pivot: 00..49 -> 20YY, 50..99 -> 19YY
        state.year = (2000 + two) if two < 50 else (1900 + two)
    elif directive == ord("m"):
        state.month = scanner.take_int(2)
    elif directive == ord("d"):
        state.day = scanner.take_int(2)
    elif directive == ord("H"):
        state.hour = scanner.take_int(2)
        state.hour_from_12 = False
    elif directive == ord("I"):
        state.hour = scanner.take_int(2)
        state.hour_from_12 = True
    elif directive == ord("M"):
        state.minute = scanner.take_int(2)
    elif directive == ord("S"):
        state.second = scanner.take_int(2)
    elif directive == ord("p"):
        var token = scanner.take_text(2)
        if token == "AM":
            state.is_pm = False
        elif token == "PM":
            state.is_pm = True
        else:
            raise Error(
                "chrono.Strftime: %p expected 'AM' or 'PM', got '" + token + "'"
            )
        state.saw_period = True
    elif directive == ord("A"):
        state.parsed_weekday = _consume_weekday_name(scanner, abbreviated=False)
    elif directive == ord("a"):
        state.parsed_weekday = _consume_weekday_name(scanner, abbreviated=True)
    elif directive == ord("B"):
        state.month = _consume_month_name(scanner, abbreviated=False)
    elif directive == ord("b"):
        state.month = _consume_month_name(scanner, abbreviated=True)
    elif directive == ord("j"):
        raise Error(
            "chrono.Strftime: %j (day-of-year) is not supported by parse —"
            " use %m + %d"
        )
    elif directive == _PERCENT:
        scanner.expect("%")
    else:
        raise Error(
            "chrono.Strftime: unsupported directive '%"
            + chr(directive)
            + "' at pattern position "
            + String(position)
        )


def _consume_weekday_name(
    mut scanner: Scanner, abbreviated: Bool
) raises -> Int:
    """Consume a weekday name (or its 3-char abbreviation) from the scanner
    and return the ISO number 1..7. The caller compares it against the
    resolved date's weekday at `_ParseState.into_datetime`."""
    for iso in range(1, 8):
        var full = String(Weekday(raw=UInt8(iso)).name())
        var name = String(full[byte=0:3]) if abbreviated else full
        if scanner.accept_text(name):
            return iso
    raise Error(
        "chrono.Strftime: expected weekday name at position "
        + String(scanner.position())
    )


def _consume_month_name(mut scanner: Scanner, abbreviated: Bool) raises -> Int:
    """Consume a month name (or its 3-char abbreviation) from the scanner and
    return the 1..12 month number. Tries each Month in calendar order; first
    match wins (no two names share a prefix that disambiguates differently)."""
    for m in range(1, 13):
        var full = String(Month(raw=UInt8(m)).name())
        var name = String(full[byte=0:3]) if abbreviated else full
        if scanner.accept_text(name):
            return m
    raise Error(
        "chrono.Strftime: expected month name at position "
        + String(scanner.position())
    )
