# Instant — a point on a timeline (the affine *point*): Instant - Instant = Duration,
# Instant +/- Duration = Instant. Parameterized by the clock it reads, so a REALTIME
# point and a MONOTONIC point are different types and cannot be mixed (compile error).
# Stored as a Duration since the clock's epoch.
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: from spec; now() reads the OS clock (libc). Arithmetic verified by KAT;
# now() verified by range/monotonicity properties (a live clock cannot be KAT'd).

from chrono._core.clock import Clock
from chrono._core.clock_id import ClockId
from chrono.duration import Duration


struct Instant[clock: ClockId = ClockId.REALTIME](
    Comparable, TrivialRegisterPassable
):
    var _since_epoch: Duration

    @always_inline
    def __init__(out self, since_epoch: Duration):
        self._since_epoch = since_epoch

    @staticmethod
    @always_inline
    def unix_epoch() -> Self:
        return Self(Duration.ZERO)

    @staticmethod
    def now() raises -> Self:
        return Self(Clock.now(Self.clock))

    @staticmethod
    @always_inline
    def from_seconds_since_epoch(seconds: Int64) -> Self:
        return Self(Duration.from_seconds(seconds))

    @staticmethod
    @always_inline
    def from_milliseconds_since_epoch(milliseconds: Int64) -> Self:
        return Self(Duration.from_milliseconds(milliseconds))

    @always_inline
    def since_epoch(self) -> Duration:
        return self._since_epoch

    @always_inline
    def seconds_since_epoch(self) -> Int64:
        return self._since_epoch.total_seconds()

    @always_inline
    def milliseconds_since_epoch(self) -> Int64:
        return self._since_epoch.total_milliseconds()

    @always_inline
    def __sub__(self, other: Self) -> Duration:
        """point - point = vector (only between same-clock instants)."""
        return self._since_epoch - other._since_epoch

    @always_inline
    def __add__(self, duration: Duration) -> Self:
        return Self(self._since_epoch + duration)

    @always_inline
    def __sub__(self, duration: Duration) -> Self:
        return Self(self._since_epoch - duration)

    # --- comparison (delegates to the underlying Duration's comparators) ---

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._since_epoch == other._since_epoch

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        return self._since_epoch < other._since_epoch

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self < other or self == other

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return not (self <= other)

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return not (self < other)
