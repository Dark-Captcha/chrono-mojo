# Weekday / Month — typed enums (comptime members, DType-style). Weekday uses ISO
# numbering (Monday = 1 .. Sunday = 7); Month is 1..12. Pure value types with no
# calendar dependency.
#
# Construction: positional `Weekday(value)` / `Month(value)` validates; the kw-only
# `raw=` escape hatch skips validation for internal callers that already know the
# value is in range (e.g. `Date.weekday()` reading the floor-mod weekday from the
# civil core). Pattern mirrors `Date.__init__(*, days_since_epoch=…)`.
#
# These two enums share `enums.mojo` rather than splitting into `weekday.mojo` +
# `month.mojo`: they are the same shape (UInt8 discriminant + name() returning
# StaticString) and the rest of the library reads them as a pair (strftime,
# rfc2822, natural — all iterate over both). The "one type per file" naming rule
# (`docs/05-naming.md`) explicitly carves an exception for shape-matched enum
# pairs in the same conceptual space.
#
# `from_name(text, *, abbreviated)` is the single home of the English name lookup
# used by every parser (strftime %A/%a/%B/%b, RFC 2822 weekday/month abbrev,
# natural-language weekday, RRULE BYDAY 2-letter). Callers pass the input verbatim
# in the case they want to match (rfc2822 = capitalized, natural = lower, rrule =
# upper) since case-folding belongs to the caller's grammar, not to this lookup.
#
# Facets: tier T0 (spine) | safety sound (validating ctor) | quantum n/a.
# Honesty: from spec (ISO 8601 weekday numbering, Gregorian month numbering);
# names are English / C-POSIX locale. KAT in tests/types/test_enums.mojo.

from std.collections.inline_array import InlineArray


comptime _WEEKDAY_NAMES: InlineArray[StaticString, 7] = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
]

comptime _MONTH_NAMES: InlineArray[StaticString, 12] = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
]


def _name_matches(
    candidate: StaticString, text: StringSlice, *, prefix_len: Int
) -> Bool:
    """Whether `text` equals the first `prefix_len` bytes of `candidate`
    (`prefix_len == 0` means "match the whole name"). Pure byte compare;
    case-folding is the caller's concern."""
    var want_len = prefix_len if prefix_len > 0 else candidate.byte_length()
    if text.byte_length() != want_len:
        return False
    var c = candidate.as_bytes()
    var t = text.as_bytes()
    for i in range(want_len):
        if c[i] != t[i]:
            return False
    return True


struct Weekday(Equatable, ImplicitlyCopyable, Movable):
    var _value: UInt8  # ISO: 1 = Monday .. 7 = Sunday

    @always_inline
    def __init__(out self, *, raw: UInt8):
        """Internal: skip validation. Callers must guarantee `raw` in 1..7."""
        self._value = raw

    @always_inline
    def __init__(out self, value: UInt8) raises:
        """Validating: rejects `value` outside the ISO 1..7 range."""
        if value < 1 or value > 7:
            raise Error(
                "chrono.Weekday: ISO weekday must be 1..7, got "
                + String(Int(value))
            )
        self._value = value

    comptime MONDAY = Weekday(raw=1)
    comptime TUESDAY = Weekday(raw=2)
    comptime WEDNESDAY = Weekday(raw=3)
    comptime THURSDAY = Weekday(raw=4)
    comptime FRIDAY = Weekday(raw=5)
    comptime SATURDAY = Weekday(raw=6)
    comptime SUNDAY = Weekday(raw=7)

    @always_inline
    def iso_number(self) -> Int:
        return Int(self._value)

    @always_inline
    def name(self) -> StaticString:
        return _WEEKDAY_NAMES[Int(self._value) - 1]

    @staticmethod
    def from_name(text: StringSlice, *, prefix_len: Int = 0) raises -> Weekday:
        """Match `text` to a weekday name. `prefix_len=0` matches the full
        English name ("Monday"); `prefix_len=3` matches the IMF-fixdate /
        strftime abbreviation ("Mon"); `prefix_len=2` matches the RFC 5545
        RRULE BYDAY token ("MO"). Comparison is byte-exact — the caller
        normalizes case to match the name table's casing (Monday / Mon are
        title-case in the table; rrule upper-cases "MO" before calling)."""
        for i in range(7):
            if _name_matches(_WEEKDAY_NAMES[i], text, prefix_len=prefix_len):
                return Weekday(raw=UInt8(i + 1))
        raise Error(
            "chrono.Weekday: unknown weekday name '" + String(text) + "'"
        )

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._value == other._value

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return self._value != other._value


struct Month(Equatable, ImplicitlyCopyable, Movable):
    var _value: UInt8  # 1 = January .. 12 = December

    @always_inline
    def __init__(out self, *, raw: UInt8):
        """Internal: skip validation. Callers must guarantee `raw` in 1..12."""
        self._value = raw

    @always_inline
    def __init__(out self, value: UInt8) raises:
        """Validating: rejects `value` outside the 1..12 range."""
        if value < 1 or value > 12:
            raise Error(
                "chrono.Month: month must be 1..12, got " + String(Int(value))
            )
        self._value = value

    comptime JANUARY = Month(raw=1)
    comptime FEBRUARY = Month(raw=2)
    comptime MARCH = Month(raw=3)
    comptime APRIL = Month(raw=4)
    comptime MAY = Month(raw=5)
    comptime JUNE = Month(raw=6)
    comptime JULY = Month(raw=7)
    comptime AUGUST = Month(raw=8)
    comptime SEPTEMBER = Month(raw=9)
    comptime OCTOBER = Month(raw=10)
    comptime NOVEMBER = Month(raw=11)
    comptime DECEMBER = Month(raw=12)

    @always_inline
    def number(self) -> Int:
        return Int(self._value)

    @always_inline
    def name(self) -> StaticString:
        return _MONTH_NAMES[Int(self._value) - 1]

    @staticmethod
    def from_name(text: StringSlice, *, prefix_len: Int = 0) raises -> Month:
        """Match `text` to a month name. `prefix_len=0` matches the full
        English name; `prefix_len=3` matches the standard 3-letter
        abbreviation (Jan / Feb / …). Byte-exact comparison."""
        for i in range(12):
            if _name_matches(_MONTH_NAMES[i], text, prefix_len=prefix_len):
                return Month(raw=UInt8(i + 1))
        raise Error("chrono.Month: unknown month name '" + String(text) + "'")

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._value == other._value

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return self._value != other._value
