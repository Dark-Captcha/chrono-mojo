# ClockId — which timeline a reading comes from. A typed enum (comptime members,
# DType-style): being a distinct type lets `Instant[clock]` forbid mixing a realtime
# point with a monotonic one. The stored value is chrono's own logical discriminant,
# NOT a raw OS clockid_t — the real clock number is resolved per-OS in `clock.mojo`
# (it differs by platform: CLOCK_MONOTONIC is 1 on Linux but 6 on macOS).


struct ClockId(Equatable, ImplicitlyCopyable, Movable):
    var _value: Int32  # logical discriminant: 0 = realtime, 1 = monotonic

    @always_inline
    def __init__(out self, *, raw: Int32):
        """Internal: skip validation. Callers must guarantee `raw` is a declared
        discriminant (REALTIME=0 or MONOTONIC=1). There is no validating
        positional ctor — the only public way to obtain a ClockId is via the
        comptime singletons below, so a garbage discriminant is unreachable."""
        self._value = raw

    comptime REALTIME = ClockId(raw=0)  # wall clock (may jump)
    comptime MONOTONIC = ClockId(raw=1)  # never jumps; for elapsed time

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._value == other._value

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)
