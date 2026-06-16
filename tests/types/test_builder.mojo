# DateTimeBuilder: fluent chaining, epoch defaults for unset fields, and that build()
# validates (out-of-range fields raise).

from chrono.builder import DateTimeBuilder
from chrono.datetime import DateTime


def run() raises -> Int:
    var f = 0

    # full chain
    var full = (
        DateTimeBuilder()
        .year(2026)
        .month(6)
        .day(15)
        .hour(14)
        .minute(30)
        .second(45)
        .nanosecond(500_000_000)
        .build()
    )
    if full != DateTime(2026, 6, 15, 14, 30, 45, 500_000_000):
        print("FAIL builder full chain")
        f += 1

    # partial chain: unset fields default to the epoch
    if DateTimeBuilder().year(2026).month(6).day(15).build() != DateTime(
        2026, 6, 15, 0, 0, 0
    ):
        print("FAIL builder partial defaults")
        f += 1
    if DateTimeBuilder().build() != DateTime(1970, 1, 1, 0, 0, 0):
        print("FAIL builder all-default epoch")
        f += 1

    # build() validates
    var raised = False
    try:
        _ = DateTimeBuilder().year(2026).month(13).day(1).build()
    except:
        raised = True
    if not raised:
        print("FAIL builder accepted month 13")
        f += 1
    raised = False
    try:
        _ = DateTimeBuilder().year(2026).month(2).day(30).build()
    except:
        raised = True
    if not raised:
        print("FAIL builder accepted Feb 30")
        f += 1

    if f == 0:
        print("test_builder: PASS")
    return f
