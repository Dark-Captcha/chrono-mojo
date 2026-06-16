# Time — a wall-clock time of day, the time half of the naive *view*. Stored as a
# single Int64 nanosecond count since midnight, so comparison is an integer op; the
# hour/minute/second/nanosecond fields are decoded on demand.
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: from spec; KAT-verified. A leap second (`:60`) is rejected by the
# validating constructor (it is accepted only later, by RFC parsers, then folded).

from chrono._core.units import (
    NANOS_PER_HOUR,
    NANOS_PER_MINUTE,
    NANOS_PER_SECOND,
    NANOS_PER_DAY,
    SECONDS_PER_MINUTE,
    MINUTES_PER_HOUR,
    HOURS_PER_DAY,
)


struct Time(Comparable, TrivialRegisterPassable):
    var _nanoseconds_since_midnight: Int64

    @always_inline
    def __init__(out self, *, nanoseconds_since_midnight: Int64):
        """Internal: construct directly from the nanosecond-of-day count."""
        self._nanoseconds_since_midnight = nanoseconds_since_midnight

    def __init__(
        out self, hour: Int, minute: Int, second: Int = 0, nanosecond: Int = 0
    ) raises:
        """Validating construction; raises on an out-of-range field."""
        if hour < 0 or hour >= HOURS_PER_DAY:
            raise Error(
                "chrono.Time: hour out of range (0..23), got " + String(hour)
            )
        if minute < 0 or minute >= MINUTES_PER_HOUR:
            raise Error(
                "chrono.Time: minute out of range (0..59), got "
                + String(minute)
            )
        if second < 0 or second >= SECONDS_PER_MINUTE:
            raise Error(
                "chrono.Time: second out of range (0..59), got "
                + String(second)
            )
        if nanosecond < 0 or nanosecond >= NANOS_PER_SECOND:
            raise Error(
                "chrono.Time: nanosecond out of range (0..999999999), got "
                + String(nanosecond)
            )
        self._nanoseconds_since_midnight = (
            Int64(hour) * NANOS_PER_HOUR
            + Int64(minute) * NANOS_PER_MINUTE
            + Int64(second) * NANOS_PER_SECOND
            + Int64(nanosecond)
        )

    comptime MIDNIGHT = Time(nanoseconds_since_midnight=0)

    @staticmethod
    def from_nanoseconds_since_midnight(nanoseconds: Int64) raises -> Self:
        if nanoseconds < 0 or nanoseconds >= NANOS_PER_DAY:
            raise Error(
                "chrono.Time: nanoseconds-of-day out of range"
                " (0..86399999999999), got " + String(Int(nanoseconds))
            )
        return Self(nanoseconds_since_midnight=nanoseconds)

    @always_inline
    def hour(self) -> Int:
        return Int(self._nanoseconds_since_midnight // NANOS_PER_HOUR)

    @always_inline
    def minute(self) -> Int:
        return Int(
            (self._nanoseconds_since_midnight // NANOS_PER_MINUTE)
            % MINUTES_PER_HOUR
        )

    @always_inline
    def second(self) -> Int:
        return Int(
            (self._nanoseconds_since_midnight // NANOS_PER_SECOND)
            % SECONDS_PER_MINUTE
        )

    @always_inline
    def nanosecond(self) -> Int:
        return Int(self._nanoseconds_since_midnight % NANOS_PER_SECOND)

    @always_inline
    def nanoseconds_since_midnight(self) -> Int64:
        return self._nanoseconds_since_midnight

    # --- comparison (delegates to the single Int64 field) ---

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return (
            self._nanoseconds_since_midnight
            == other._nanoseconds_since_midnight
        )

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        return (
            self._nanoseconds_since_midnight < other._nanoseconds_since_midnight
        )

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self < other or self == other

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return not (self <= other)

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return not (self < other)
