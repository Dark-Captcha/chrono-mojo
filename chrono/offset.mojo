# Offset — a fixed offset from UTC, in seconds east of UTC (e.g. +07:00 -> +25200).
# The minimal time-zone value RFC 3339 needs; for DST-aware projection through a
# named IANA zone, see `chrono.timezone.Timezone[transition_count, type_count]`.
#
# Facets: tier T0 (spine) | safety sound (factories range-check) | quantum n/a.
# Honesty: from spec (RFC 3339 §4.3 / IANA tz). The ±18:00 cap is the IANA upper
# bound — the largest real civil offset is +14:00 (Pacific/Kiritimati). KAT in
# tests/types/test_offset.mojo (all six comparison operators + bounds-raise on
# both halves of the range).

from chrono._core.units import SECONDS_PER_HOUR, SECONDS_PER_MINUTE

# RFC 3339 §5.6 + IANA: the absolute offset never exceeds 18:00 (the largest real
# civil offset is +14:00 — Pacific/Kiritimati — with a comfortable margin).
comptime _MAX_OFFSET_HOURS = 18
comptime _MAX_OFFSET_SECONDS = _MAX_OFFSET_HOURS * SECONDS_PER_HOUR


struct Offset(Comparable, TrivialRegisterPassable):
    var _seconds: Int32  # seconds east of UTC

    @always_inline
    def __init__(out self, *, total_seconds: Int32):
        self._seconds = total_seconds

    def __init__(out self, hours: Int, minutes: Int = 0) raises:
        """`hours`/`minutes` share a sign; for a negative offset pass both negative
        (e.g. Offset(-5, -30) is -05:30)."""
        var total = hours * SECONDS_PER_HOUR + minutes * SECONDS_PER_MINUTE
        if total < -_MAX_OFFSET_SECONDS or total > _MAX_OFFSET_SECONDS:
            raise Error(
                "chrono.Offset: out of range (|offset| <= 18:00), got "
                + String(hours)
                + "h "
                + String(minutes)
                + "m ("
                + String(total)
                + " seconds)"
            )
        self._seconds = Int32(total)

    comptime UTC = Offset(total_seconds=0)

    @staticmethod
    def from_seconds(seconds: Int) raises -> Self:
        if seconds < -_MAX_OFFSET_SECONDS or seconds > _MAX_OFFSET_SECONDS:
            raise Error(
                "chrono.Offset: from_seconds out of range (|offset| <= 18:00),"
                " got " + String(seconds) + " seconds"
            )
        return Self(total_seconds=Int32(seconds))

    @always_inline
    def total_seconds(self) -> Int:
        return Int(self._seconds)

    @always_inline
    def is_utc(self) -> Bool:
        return self._seconds == 0

    # --- comparison (delegates to the single Int32 field) ---

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._seconds == other._seconds

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        return self._seconds < other._seconds

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self < other or self == other

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return not (self <= other)

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return not (self < other)
