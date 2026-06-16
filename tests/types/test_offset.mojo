# Offset: construction (signed hours/minutes + from_seconds), the 18:00 bound
# RFC 3339 §5.6 / IANA mandates, is_utc(), every comparison operator, and the
# raise paths. Until this file the public Offset surface had ZERO direct tests
# — the bounds claim in `chrono/offset.mojo` rested on review alone.

from chrono.offset import Offset


def _rejects_init(hours: Int, minutes: Int) raises -> Int:
    try:
        _ = Offset(hours, minutes)
    except:
        return 0
    print("FAIL Offset(", hours, ",", minutes, ") was not rejected")
    return 1


def _rejects_seconds(seconds: Int) raises -> Int:
    try:
        _ = Offset.from_seconds(seconds)
    except:
        return 0
    print("FAIL Offset.from_seconds(", seconds, ") was not rejected")
    return 1


def run() raises -> Int:
    var f = 0

    # --- construction + total_seconds ---
    if Offset.UTC.total_seconds() != 0:
        print("FAIL UTC total_seconds")
        f += 1
    if Offset(7).total_seconds() != 25200:
        print("FAIL +07 total_seconds")
        f += 1
    if Offset(-5, -30).total_seconds() != -19800:
        print("FAIL -05:30 total_seconds (asymmetric-sign convention)")
        f += 1
    if Offset.from_seconds(3600).total_seconds() != 3600:
        print("FAIL from_seconds")
        f += 1

    # --- is_utc ---
    if not Offset.UTC.is_utc():
        print("FAIL Offset.UTC.is_utc")
        f += 1
    if Offset(1).is_utc():
        print("FAIL +01:00 is_utc returned True")
        f += 1

    # --- comparison operators (all six) ---
    var a = Offset(-5)
    var b = Offset(0)
    var c = Offset(7)
    if not (a < b and b < c):
        print("FAIL Offset.__lt__")
        f += 1
    if not (a <= a and a <= b):
        print("FAIL Offset.__le__")
        f += 1
    if not (c > b and b > a):
        print("FAIL Offset.__gt__")
        f += 1
    if not (c >= c and c >= b):
        print("FAIL Offset.__ge__")
        f += 1
    if not (b == Offset.UTC):
        print("FAIL Offset.__eq__")
        f += 1
    if not (a != b):
        print("FAIL Offset.__ne__")
        f += 1

    # --- bounds: |offset| <= 18:00. The exact boundary is accepted; one step
    # over MUST raise (both Offset(h, m) and Offset.from_seconds).
    if Offset(18).total_seconds() != 64800:
        print("FAIL Offset(18) accepted but wrong value")
        f += 1
    if Offset(-18).total_seconds() != -64800:
        print("FAIL Offset(-18) accepted but wrong value")
        f += 1
    f += _rejects_init(19, 0)
    f += _rejects_init(-19, 0)
    f += _rejects_init(18, 1)
    f += _rejects_init(-18, -1)
    f += _rejects_seconds(64801)
    f += _rejects_seconds(-64801)

    if f == 0:
        print("test_offset: PASS")
    return f
