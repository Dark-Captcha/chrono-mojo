# OffsetDateTime: absolute-instant conversion (differential vs Python aware
# datetimes), from_instant round-trip, equality/ordering by the absolute moment,
# and field accessors.

from chrono.offset_datetime import OffsetDateTime
from chrono.datetime import DateTime
from chrono.offset import Offset
from chrono.instant import Instant


def run() raises -> Int:
    var f = 0

    # --- to_instant (differential vs Python) ---
    var odt = OffsetDateTime(DateTime(2026, 6, 15, 14, 30, 45), Offset(7))
    if odt.to_instant().seconds_since_epoch() != 1781508645:
        print("FAIL to_instant +07", odt.to_instant().seconds_since_epoch())
        f += 1
    if (
        OffsetDateTime(DateTime(2026, 6, 15, 14, 30, 45), Offset.UTC)
        .to_instant()
        .seconds_since_epoch()
        != 1781533845
    ):
        print("FAIL to_instant UTC")
        f += 1

    # --- from_instant round-trip ---
    var back = OffsetDateTime.from_instant(
        Instant.from_seconds_since_epoch(1781508645), Offset(7)
    )
    if (
        back.year() != 2026
        or back.month().number() != 6
        or back.day() != 15
        or back.hour() != 14
        or back.minute() != 30
        or back.second() != 45
        or back.offset().total_seconds() != 25200
    ):
        print("FAIL from_instant round-trip")
        f += 1

    # --- equality/ordering by the absolute moment ---
    var a = OffsetDateTime(DateTime(2026, 1, 1, 12, 0, 0), Offset.UTC)
    var b = OffsetDateTime(DateTime(2026, 1, 1, 13, 0, 0), Offset(1))
    if not (a == b):  # same moment, different offset
        print("FAIL == across offsets")
        f += 1
    var c = OffsetDateTime(DateTime(2026, 1, 1, 12, 0, 1), Offset.UTC)
    if not (a < c):
        print("FAIL ordering by instant")
        f += 1

    # --- accessors ---
    if odt.datetime() != DateTime(2026, 6, 15, 14, 30, 45):
        print("FAIL datetime()")
        f += 1

    if f == 0:
        print("test_offset_datetime: PASS")
    return f
