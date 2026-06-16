# Duration: construction (floor-normalized), accessors, affine arithmetic, and
# comparison. Construction/arithmetic vectors are differential vs Python
# `datetime.timedelta` (microsecond oracle); pure-nanosecond cases are KAT.

from chrono.duration import Duration


def _check(
    d: Duration, seconds: Int64, nanosecond: UInt32, label: String
) raises -> Int:
    if d.total_seconds() != seconds or d.nanosecond() != nanosecond:
        print(
            "FAIL",
            label,
            "got",
            d.total_seconds(),
            d.nanosecond(),
            "want",
            seconds,
            nanosecond,
        )
        return 1
    return 0


def run() raises -> Int:
    var f = 0

    # --- construction (differential vs Python timedelta) ---
    f += _check(Duration.from_seconds(5), 5, 0, "from_seconds(5)")
    f += _check(Duration.from_seconds(-1), -1, 0, "from_seconds(-1)")
    f += _check(Duration.from_milliseconds(1500), 1, 500_000_000, "ms(1500)")
    f += _check(Duration.from_milliseconds(-500), -1, 500_000_000, "ms(-500)")
    f += _check(Duration.from_microseconds(-1), -1, 999_999_000, "us(-1)")
    f += _check(Duration.from_minutes(2), 120, 0, "min(2)")
    f += _check(Duration.from_hours(25), 90000, 0, "hours(25)")
    f += _check(Duration.from_days(-2), -172800, 0, "days(-2)")
    # nanosecond resolution (beyond Python's microsecond oracle): KAT
    f += _check(
        Duration.from_nanoseconds(1_500_000_000), 1, 500_000_000, "ns(1.5e9)"
    )
    f += _check(Duration.from_nanoseconds(-1), -1, 999_999_999, "ns(-1)")

    # --- arithmetic (vs timedelta) ---
    var a = Duration.from_milliseconds(500)
    var b = Duration.from_milliseconds(800)
    f += _check(a + b, 1, 300_000_000, "a+b")
    f += _check(a - b, -1, 700_000_000, "a-b")
    f += _check(-a, -1, 500_000_000, "-a")
    f += _check(a * 3, 1, 500_000_000, "a*3")
    f += _check(a * -2, -1, 0, "a*-2")
    f += _check(
        Duration.from_milliseconds(-500).__abs__(), 0, 500_000_000, "abs"
    )

    # --- accessors ---
    var neg = Duration.from_milliseconds(-500)
    if neg.total_seconds() != -1:
        print("FAIL total_seconds neg")
        f += 1
    if neg.total_milliseconds() != -500:
        print("FAIL total_milliseconds neg")
        f += 1
    if neg.total_microseconds() != -500000:
        print("FAIL total_microseconds neg")
        f += 1
    if Duration.from_hours(25).total_milliseconds() != 90000000:
        print("FAIL total_milliseconds hours")
        f += 1
    if not Duration.ZERO.is_zero():
        print("FAIL ZERO.is_zero")
        f += 1
    if not neg.is_negative():
        print("FAIL neg.is_negative")
        f += 1
    if Duration.from_seconds(1).is_negative():
        print("FAIL pos.is_negative")
        f += 1

    # --- comparison ---
    if not (
        Duration.from_milliseconds(-500) < Duration.from_milliseconds(-300)
    ):
        print("FAIL cmp neg<neg")
        f += 1
    if not (Duration.from_seconds(1) > Duration.from_milliseconds(999)):
        print("FAIL cmp >")
        f += 1
    if not (
        Duration.from_milliseconds(500) == Duration.from_microseconds(500000)
    ):
        print("FAIL cmp ==")
        f += 1
    if Duration.from_seconds(-1) >= Duration.ZERO:
        print("FAIL cmp neg>=zero")
        f += 1
    if not (Duration.ZERO <= Duration.from_nanoseconds(1)):
        print("FAIL cmp zero<=tiny")
        f += 1

    # Range constants are reachable and reflect the i64 second range.
    if Duration.MIN.total_seconds() != Int64.MIN:
        print("FAIL MIN.total_seconds")
        f += 1
    if Duration.MAX.total_seconds() != Int64.MAX:
        print("FAIL MAX.total_seconds")
        f += 1

    # Coarse-unit factories raise on i64 overflow (the audit defect was a
    # silent wrap on `from_days(Int64.MAX)`).
    var raised = False
    try:
        _ = Duration.from_days(Int64.MAX)
    except:
        raised = True
    if not raised:
        print("FAIL from_days accepted Int64.MAX")
        f += 1
    raised = False
    try:
        _ = Duration.from_hours(Int64.MAX)
    except:
        raised = True
    if not raised:
        print("FAIL from_hours accepted Int64.MAX")
        f += 1
    raised = False
    try:
        _ = Duration.from_minutes(Int64.MIN)
    except:
        raised = True
    if not raised:
        print("FAIL from_minutes accepted Int64.MIN")
        f += 1
    # Boundary: the largest exact `from_days` is `Int64.MAX // 86400`.
    var safe_days = Int64.MAX // 86400
    if Duration.from_days(safe_days).total_seconds() != safe_days * 86400:
        print("FAIL from_days at the safe boundary")
        f += 1

    if f == 0:
        print("test_duration: PASS")
    return f
