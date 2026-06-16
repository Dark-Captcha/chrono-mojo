# Clock — reads a POSIX clock via clock_gettime(2) over libc FFI, returning a
# Duration since that clock's epoch (pure Mojo, no Python). The timespec is two
# contiguous 64-bit words (tv_sec, tv_nsec) on both Linux and macOS.
#
# clock_gettime exists on Linux and macOS (10.12+), but its clockid_t numbers are
# NOT the same: CLOCK_REALTIME is 0 on both, yet CLOCK_MONOTONIC is 1 on Linux and
# 6 on macOS (Darwin). So ClockId stays chrono's logical identifier and the real
# clockid_t is resolved here, gated on the target OS at compile time. Windows has no
# clock_gettime (it would need GetSystemTimePreciseAsFileTime) and Mojo does not
# target it yet; building now() for such a target raises until a branch is added.
#
# CLOCK_REALTIME's epoch is the Unix epoch; CLOCK_MONOTONIC's origin is unspecified
# (only differences between monotonic readings are meaningful).

from std.ffi import external_call
from std.sys.info import CompilationTarget

from chrono._core.clock_id import ClockId
from chrono._core.units import NANOS_PER_SECOND
from chrono.duration import Duration

# Real POSIX clockid_t values for the target OS (resolved at compile time).
comptime _CLOCK_REALTIME = 0  # 0 on both Linux and macOS
comptime _CLOCK_MONOTONIC = 6 if CompilationTarget.is_macos() else 1


struct Clock:
    @staticmethod
    def now(clock: ClockId) raises -> Duration:
        comptime if not (
            CompilationTarget.is_linux() or CompilationTarget.is_macos()
        ):
            raise Error(
                "chrono.clock: now() requires Linux or macOS (POSIX"
                " clock_gettime); this target is unsupported"
            )
        var clockid = Int32(
            _CLOCK_REALTIME
        ) if clock == ClockId.REALTIME else Int32(_CLOCK_MONOTONIC)
        var timespec = List[Int64](unsafe_uninit_length=2)  # tv_sec, tv_nsec
        var return_code = external_call["clock_gettime", Int32](
            clockid, timespec.unsafe_ptr()
        )
        if return_code != 0:
            raise Error("chrono.clock: clock_gettime(2) failed")
        # POSIX guarantees tv_nsec in [0, 1e9); a broken VDSO that returned
        # otherwise would smuggle an invariant violation through the silent
        # `UInt32(...)` cast straight into Duration's storage.
        var tv_nsec = timespec[1]
        if tv_nsec < 0 or tv_nsec >= NANOS_PER_SECOND:
            raise Error(
                "chrono.clock: kernel returned tv_nsec out of POSIX range"
                " [0, 1e9), got " + String(tv_nsec)
            )
        return Duration(timespec[0], UInt32(tv_nsec))
