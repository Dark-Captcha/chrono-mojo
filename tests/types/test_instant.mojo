# Instant: affine arithmetic (point-point = Duration, point +/- Duration = point),
# comparison, and the UNIX_EPOCH anchor are KAT. now() (which exercises the clock
# FFI seam) is checked by properties: a realtime reading lands in a sane window, two
# monotonic readings never go backward, and the monotonic clock is a distinct
# timeline from realtime (which locks the per-OS clockid mapping in clock.mojo).

from chrono.instant import Instant
from chrono.duration import Duration
from chrono._core.clock_id import ClockId


def run() raises -> Int:
    var f = 0

    # --- affine arithmetic (KAT) ---
    var t0 = Instant.from_seconds_since_epoch(1000)
    var t1 = t0 + Duration.from_seconds(60)
    if t1.seconds_since_epoch() != 1060:
        print("FAIL instant + duration")
        f += 1
    if (t1 - t0).total_seconds() != 60:
        print("FAIL instant - instant")
        f += 1
    if (t1 - Duration.from_seconds(100)).seconds_since_epoch() != 960:
        print("FAIL instant - duration")
        f += 1

    var tm = Instant.from_milliseconds_since_epoch(1500)
    if tm.milliseconds_since_epoch() != 1500 or tm.seconds_since_epoch() != 1:
        print("FAIL from/to milliseconds")
        f += 1

    if Instant.unix_epoch().seconds_since_epoch() != 0:
        print("FAIL UNIX_EPOCH")
        f += 1

    # --- comparison (KAT) ---
    var early = Instant.from_seconds_since_epoch(960)
    if not (early < t0):
        print("FAIL cmp <")
        f += 1
    if not (t1 > t0):
        print("FAIL cmp >")
        f += 1
    if not (
        Instant.from_seconds_since_epoch(5)
        == Instant.from_seconds_since_epoch(5)
    ):
        print("FAIL cmp ==")
        f += 1

    # --- now() seam: realtime reading is in a sane window (2024-01-01 .. 2100) ---
    var now_seconds = Instant.now().seconds_since_epoch()
    if now_seconds < 1704067200 or now_seconds > 4102444800:
        print("FAIL now() out of range", now_seconds)
        f += 1

    # --- monotonic clock never goes backward ---
    var mono_a = Instant[ClockId.MONOTONIC].now()
    var mono_b = Instant[ClockId.MONOTONIC].now()
    if mono_b < mono_a:
        print("FAIL monotonic went backward")
        f += 1

    # --- monotonic is a DISTINCT timeline (uptime), not realtime: its reading is
    # far below seconds-since-1970. Locks the per-OS clockid mapping (CLOCK_MONOTONIC
    # is 1 on Linux, 6 on macOS) — a regression aiming it at CLOCK_REALTIME fails here.
    if mono_a.seconds_since_epoch() <= 0:
        print("FAIL monotonic non-positive", mono_a.seconds_since_epoch())
        f += 1
    if mono_a.seconds_since_epoch() >= now_seconds:
        print(
            "FAIL monotonic not distinct from realtime",
            mono_a.seconds_since_epoch(),
            now_seconds,
        )
        f += 1

    if f == 0:
        print("test_instant: PASS")
    return f
