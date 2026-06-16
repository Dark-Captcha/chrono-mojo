# Duration — an exact span of time (the affine *vector*): point - point = Duration,
# point + Duration = point. Stored as whole seconds + a sub-second nanosecond part,
# normalized so 0 <= nanosecond < 1e9 with the sign carried by seconds (java.time
# model — avoids the "two signs" bug, makes lexicographic compare correct). Floor
# semantics: -0.5 s is (seconds = -1, nanosecond = 500_000_000).
#
# Range: `[Duration.MIN, Duration.MAX]` — `_seconds` is Int64 so the span is ~292
# billion years either side of zero. The validating factories raise on overflow;
# the in-register operators (+, -, *, neg, abs) wrap if a user constructs the
# extremum through the private `__init__` and then steps outside the range. That
# wrap is the standard Int64 semantics — none of chrono's own code paths cross it.
#
# Facets: tier T0 (spine) | safety sound (factories range-check user input) | quantum n/a.
# Honesty: from spec; verified by KAT + differential vs Python `datetime.timedelta`.

from chrono._core.units import (
    NANOS_PER_SECOND,
    NANOS_PER_MILLI,
    NANOS_PER_MICRO,
    MILLIS_PER_SECOND,
    MICROS_PER_SECOND,
    SECONDS_PER_MINUTE,
    SECONDS_PER_HOUR,
    SECONDS_PER_DAY,
    INT64_MAX,
)


@always_inline
def _checked_scale(
    value: Int64, scale: Int64, *, unit: StaticString
) raises -> Int64:
    """Multiply `value` by a positive `scale`, raising if the i64 product would
    overflow. The symmetric bound `|value| <= INT64_MAX // scale` is exact:
    `value = INT64_MIN // scale` is one ulp past the safe range under Mojo's
    floor-division semantics, so the negative side rejects it correctly."""
    var limit = INT64_MAX // scale
    if value > limit or value < -limit:
        raise Error(
            "chrono.Duration: from_"
            + unit
            + "("
            + String(value)
            + ") overflows the i64 second range"
        )
    return value * scale


struct Duration(Comparable, TrivialRegisterPassable):
    var _seconds: Int64  # whole seconds (carries the sign)
    var _nanosecond: UInt32  # sub-second part, 0 <= _nanosecond < 1e9

    @always_inline
    def __init__(out self, seconds: Int64, nanosecond: UInt32):
        """Direct construction; assumes `nanosecond` is already in [0, 1e9).
        Use the validating factories (`from_seconds`, `from_milliseconds`, …)
        from outside the library — this ctor exists for the normalization
        helpers and the comptime `ZERO`/`MIN`/`MAX` constants."""
        self._seconds = seconds
        self._nanosecond = nanosecond

    comptime ZERO = Duration(0, 0)
    comptime MIN = Duration(Int64.MIN, 0)
    comptime MAX = Duration(Int64.MAX, UInt32(NANOS_PER_SECOND - 1))

    # --- factories (each normalizes via floor division / floor modulo;
    #     coarse-unit factories range-check before scaling so the i64 second
    #     count never silently overflows) ---

    @staticmethod
    @always_inline
    def from_seconds(seconds: Int64) -> Self:
        return Self(seconds, 0)

    @staticmethod
    @always_inline
    def from_milliseconds(milliseconds: Int64) -> Self:
        return Self(
            milliseconds // MILLIS_PER_SECOND,
            UInt32((milliseconds % MILLIS_PER_SECOND) * NANOS_PER_MILLI),
        )

    @staticmethod
    @always_inline
    def from_microseconds(microseconds: Int64) -> Self:
        return Self(
            microseconds // MICROS_PER_SECOND,
            UInt32((microseconds % MICROS_PER_SECOND) * NANOS_PER_MICRO),
        )

    @staticmethod
    @always_inline
    def from_nanoseconds(nanoseconds: Int64) -> Self:
        return Self(
            nanoseconds // NANOS_PER_SECOND,
            UInt32(nanoseconds % NANOS_PER_SECOND),
        )

    @staticmethod
    @always_inline
    def from_minutes(minutes: Int64) raises -> Self:
        return Self.from_seconds(
            _checked_scale(minutes, Int64(SECONDS_PER_MINUTE), unit="minutes")
        )

    @staticmethod
    @always_inline
    def from_hours(hours: Int64) raises -> Self:
        return Self.from_seconds(
            _checked_scale(hours, Int64(SECONDS_PER_HOUR), unit="hours")
        )

    @staticmethod
    @always_inline
    def from_days(days: Int64) raises -> Self:
        return Self.from_seconds(
            _checked_scale(days, Int64(SECONDS_PER_DAY), unit="days")
        )

    # --- accessors (total_<unit> is the value floored to that unit) ---

    @always_inline
    def total_seconds(self) -> Int64:
        return self._seconds

    @always_inline
    def total_milliseconds(self) -> Int64:
        return (
            self._seconds * MILLIS_PER_SECOND
            + Int64(self._nanosecond) // NANOS_PER_MILLI
        )

    @always_inline
    def total_microseconds(self) -> Int64:
        return (
            self._seconds * MICROS_PER_SECOND
            + Int64(self._nanosecond) // NANOS_PER_MICRO
        )

    @always_inline
    def nanosecond(self) -> UInt32:
        return self._nanosecond

    @always_inline
    def is_zero(self) -> Bool:
        return self._seconds == 0 and self._nanosecond == 0

    @always_inline
    def is_negative(self) -> Bool:
        return self._seconds < 0

    # --- affine arithmetic ---

    @staticmethod
    @always_inline
    def _normalize(seconds: Int64, raw_nanosecond: Int64) -> Self:
        """Fold a (seconds, raw_nanosecond) pair where `raw_nanosecond` may be
        outside [0, 1e9) into the canonical form. Floor `//` / `%` carry the
        right sign on the nanosecond residue, so the result always has
        `0 <= _nanosecond < 1e9` with the sign on `_seconds`. The single home
        for the carry/wrap logic that `__add__`, `__sub__`, and `__mul__`
        otherwise repeat verbatim."""
        var carry = raw_nanosecond // NANOS_PER_SECOND
        return Self(seconds + carry, UInt32(raw_nanosecond % NANOS_PER_SECOND))

    @always_inline
    def __add__(self, other: Self) -> Self:
        return Self._normalize(
            self._seconds + other._seconds,
            Int64(self._nanosecond) + Int64(other._nanosecond),
        )

    @always_inline
    def __sub__(self, other: Self) -> Self:
        return Self._normalize(
            self._seconds - other._seconds,
            Int64(self._nanosecond) - Int64(other._nanosecond),
        )

    @always_inline
    def __neg__(self) -> Self:
        if self._nanosecond == 0:
            return Self(-self._seconds, 0)
        return Self(
            -self._seconds - 1, UInt32(NANOS_PER_SECOND) - self._nanosecond
        )

    @always_inline
    def __mul__(self, factor: Int) -> Self:
        return Self._normalize(
            self._seconds * Int64(factor),
            Int64(self._nanosecond) * Int64(factor),
        )

    @always_inline
    def __abs__(self) -> Self:
        return -self if self.is_negative() else self

    # --- comparison (lexicographic on (seconds, nanosecond); valid because the
    #     representation is floor-normalized) ---

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return (
            self._seconds == other._seconds
            and self._nanosecond == other._nanosecond
        )

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        if self._seconds != other._seconds:
            return self._seconds < other._seconds
        return self._nanosecond < other._nanosecond

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self < other or self == other

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return not (self <= other)

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return not (self < other)
