# Time: field decode, nanosecond-of-day round-trip, MIDNIGHT, comparison, and
# validation (out-of-range fields, and a leap-second `:60`, raise).

from chrono.time import Time


def run() raises -> Int:
    var f = 0

    var t = Time(14, 30, 45, 500_000_000)
    if t.hour() != 14 or t.minute() != 30 or t.second() != 45:
        print("FAIL Time h/m/s")
        f += 1
    if t.nanosecond() != 500_000_000:
        print("FAIL Time nanosecond")
        f += 1
    if t.nanoseconds_since_midnight() != 52_245_500_000_000:
        print(
            "FAIL Time nanoseconds_since_midnight",
            t.nanoseconds_since_midnight(),
        )
        f += 1

    if (
        Time.MIDNIGHT.nanoseconds_since_midnight() != 0
        or Time.MIDNIGHT.hour() != 0
    ):
        print("FAIL MIDNIGHT")
        f += 1

    var late = Time.from_nanoseconds_since_midnight(
        86_399_000_000_000
    )  # 23:59:59
    if late.hour() != 23 or late.minute() != 59 or late.second() != 59:
        print("FAIL from_nanoseconds_since_midnight")
        f += 1

    # --- comparison ---
    if not (Time(1, 0, 0) < Time(2, 0, 0)):
        print("FAIL cmp <")
        f += 1
    if not (Time(0, 0, 0) == Time.MIDNIGHT):
        print("FAIL cmp == MIDNIGHT")
        f += 1

    # --- validation ---
    var raised = False
    try:
        _ = Time(24, 0, 0)
    except:
        raised = True
    if not raised:
        print("FAIL accepted hour 24")
        f += 1
    raised = False
    try:
        _ = Time(0, 60, 0)
    except:
        raised = True
    if not raised:
        print("FAIL accepted minute 60")
        f += 1
    raised = False
    try:
        _ = Time(0, 0, 60)  # leap second rejected by the constructor
    except:
        raised = True
    if not raised:
        print("FAIL accepted second 60")
        f += 1
    raised = False
    try:
        # exactly one day in nanoseconds — out of range (nanos-of-day < 86_400 * 1e9)
        _ = Time.from_nanoseconds_since_midnight(86_400_000_000_000)
    except:
        raised = True
    if not raised:
        print("FAIL accepted nanos-of-day == day length")
        f += 1

    if f == 0:
        print("test_time: PASS")
    return f
