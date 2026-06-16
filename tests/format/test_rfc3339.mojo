# Rfc3339: format (KAT canonical strings), parse → OffsetDateTime (fields + offset,
# lower-case t/z, leap-second fold), parse_to_instant (differential vs Python
# datetime), a format round-trip, and malformed-input rejection.

from chrono.format.rfc3339 import Rfc3339
from chrono.datetime import DateTime
from chrono.offset import Offset


def _rejects(text: String) raises -> Int:
    try:
        _ = Rfc3339.parse(text)
    except:
        return 0
    print("FAIL accepted malformed:", text)
    return 1


def run() raises -> Int:
    var f = 0

    # --- format (KAT) ---
    if (
        Rfc3339.format(DateTime(2026, 6, 15, 14, 30, 45), Offset.UTC)
        != "2026-06-15T14:30:45Z"
    ):
        print("FAIL format Z")
        f += 1
    if (
        Rfc3339.format(DateTime(2026, 6, 15, 14, 30, 45), Offset(7))
        != "2026-06-15T14:30:45+07:00"
    ):
        print("FAIL format +offset")
        f += 1
    if (
        Rfc3339.format(
            DateTime(2026, 6, 15, 14, 30, 45, 500_000_000), Offset.UTC
        )
        != "2026-06-15T14:30:45.5Z"
    ):
        print("FAIL format fractional")
        f += 1
    if (
        Rfc3339.format(DateTime(2026, 1, 5, 9, 5, 0), Offset(-5, -30))
        != "2026-01-05T09:05:00-05:30"
    ):
        print("FAIL format -offset")
        f += 1

    # --- parse -> OffsetDateTime (fields + offset) ---
    var p = Rfc3339.parse("2026-06-15T14:30:45Z")
    if (
        p.datetime() != DateTime(2026, 6, 15, 14, 30, 45)
        or not p.offset().is_utc()
    ):
        print("FAIL parse Z")
        f += 1
    var p2 = Rfc3339.parse("2026-06-15T14:30:45.5+07:00")
    if (
        p2.datetime() != DateTime(2026, 6, 15, 14, 30, 45, 500_000_000)
        or p2.offset().total_seconds() != 25200
    ):
        print("FAIL parse fractional + offset")
        f += 1
    if Rfc3339.parse("2026-06-15t14:30:45z").datetime() != DateTime(
        2026, 6, 15, 14, 30, 45
    ):
        print("FAIL parse lowercase")
        f += 1
    if Rfc3339.parse("2016-12-31T23:59:60Z").datetime() != DateTime(
        2016, 12, 31, 23, 59, 59
    ):
        print("FAIL parse leap-second fold")
        f += 1
    # ':60' anywhere except 23:59 UTC is malformed (RFC 3339 §5.6 NOTE).
    f += _rejects("2016-06-15T14:30:60Z")
    f += _rejects("2016-06-15T00:00:60Z")
    # Full nanosecond precision must round-trip — was previously only ".5" tested.
    if (
        Rfc3339.parse("2026-06-15T14:30:45.123456789Z").datetime().nanosecond()
        != 123_456_789
    ):
        print("FAIL nanosecond precision")
        f += 1

    # --- parse_to_instant (differential vs Python datetime) ---
    if (
        Rfc3339.parse_to_instant("2026-06-15T14:30:45Z").seconds_since_epoch()
        != 1781533845
    ):
        print("FAIL parse_to_instant Z")
        f += 1
    if (
        Rfc3339.parse_to_instant(
            "2026-06-15T14:30:45+07:00"
        ).seconds_since_epoch()
        != 1781508645
    ):
        print("FAIL parse_to_instant +07")
        f += 1
    if (
        Rfc3339.parse_to_instant(
            "2026-06-15T14:30:45-05:00"
        ).seconds_since_epoch()
        != 1781551845
    ):
        print("FAIL parse_to_instant -05")
        f += 1
    if (
        Rfc3339.parse_to_instant("1970-01-01T00:00:00Z").seconds_since_epoch()
        != 0
    ):
        print("FAIL parse_to_instant epoch")
        f += 1

    # --- format round-trip: format(parse(s)) == s ---
    var s = String("2026-06-15T14:30:45+07:00")
    if Rfc3339.format(Rfc3339.parse(s)) != s:
        print("FAIL round-trip")
        f += 1

    # --- malformed inputs rejected ---
    f += _rejects("2026-06-15")  # too short / no time
    f += _rejects("2026-06-15T14:30:45")  # missing offset
    f += _rejects("2026-13-15T00:00:00Z")  # bad month (DateTime validates)
    f += _rejects("2026-06-15X14:30:45Z")  # bad separator

    # RFC 3339 §5.6 ABNF: each offset half is its own 2-digit range. Without
    # per-component checks, `+05:75` parsed cleanly because the TOTAL (5h75m =
    # 22500s) stayed under chrono's ±18h cap. Same for `+17:99`. Both must
    # reject now.
    f += _rejects("2026-06-15T14:30:45+05:75")  # minute >= 60
    f += _rejects(
        "2026-06-15T14:30:45+17:99"
    )  # minute >= 60 (and h close to cap)
    f += _rejects("2026-06-15T14:30:45+24:00")  # hour >= 24

    # --- format raises for a year outside the RFC 3339 range (no silent garbage) ---
    var raised_format = False
    try:
        _ = Rfc3339.format(DateTime(-44, 3, 15, 12, 0, 0), Offset.UTC)
    except:
        raised_format = True
    if not raised_format:
        print("FAIL format accepted negative year")
        f += 1

    # Year boundary: 0 accepted, 10000 rejected (RFC 3339 is 4-digit only).
    if (
        Rfc3339.format(DateTime(0, 1, 1, 0, 0, 0), Offset.UTC)
        != "0000-01-01T00:00:00Z"
    ):
        print("FAIL format year 0")
        f += 1
    raised_format = False
    try:
        _ = Rfc3339.format(DateTime(10000, 1, 1, 0, 0, 0), Offset.UTC)
    except:
        raised_format = True
    if not raised_format:
        print("FAIL format accepted year 10000")
        f += 1

    # RFC 3339 §4.3: `-00:00` is the 'offset unknown' sentinel — chrono has no
    # representation for it, so parse must reject (silently equating it to UTC
    # was the audit defect).
    f += _rejects("2026-06-15T14:30:45-00:00")

    # RFC 3339 §5.6: ':60' is only valid at 23:59 UTC. A non-UTC offset
    # disqualifies the leap-second window, so parse must reject.
    f += _rejects("2016-12-31T23:59:60+07:00")
    f += _rejects("2016-12-31T23:59:60-05:00")
    # And a `:60` at 23:59 with +00:00 (functionally UTC) still folds, since
    # `Z` and `+00:00` are semantically equal per §4.3.
    if Rfc3339.parse("2016-12-31T23:59:60+00:00").datetime() != DateTime(
        2016, 12, 31, 23, 59, 59
    ):
        print("FAIL leap-second fold with +00:00")
        f += 1

    if f == 0:
        print("test_rfc3339: PASS")
    return f
