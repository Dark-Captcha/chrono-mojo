# IsoDuration: ISO 8601 duration format + parse (KAT + round-trip), weeks, the
# month-vs-minute 'M', fractional seconds, the zero case, and malformed rejection.

from chrono.format.iso_duration import IsoDuration, IsoDurationValue
from chrono.span import Span
from chrono.duration import Duration


def run() raises -> Int:
    var f = 0

    # --- format (KAT) ---
    if (
        IsoDuration.format(
            Span(1, 2, 3), Duration.from_seconds(4 * 3600 + 5 * 60 + 6)
        )
        != "P1Y2M3DT4H5M6S"
    ):
        print("FAIL format full")
        f += 1
    if IsoDuration.format(Span(), Duration.from_seconds(5400)) != "PT1H30M":
        print("FAIL format time-only")
        f += 1
    if IsoDuration.format(Span(0, 0, 7), Duration.ZERO) != "P7D":
        print("FAIL format days")
        f += 1
    if IsoDuration.format(Span(), Duration.from_milliseconds(1500)) != "PT1.5S":
        print("FAIL format fractional")
        f += 1
    if IsoDuration.format(Span(), Duration.ZERO) != "PT0S":
        print("FAIL format zero")
        f += 1

    # --- parse (KAT) ---
    if IsoDuration.parse("P1Y2M3DT4H5M6S") != IsoDurationValue(
        Span(1, 2, 3), Duration.from_seconds(4 * 3600 + 5 * 60 + 6)
    ):
        print("FAIL parse full")
        f += 1
    if IsoDuration.parse("PT1H30M") != IsoDurationValue(
        Span(), Duration.from_seconds(5400)
    ):
        print("FAIL parse time-only")
        f += 1
    if IsoDuration.parse("P1W") != IsoDurationValue(
        Span(0, 0, 7), Duration.ZERO
    ):
        print("FAIL parse weeks")
        f += 1
    if IsoDuration.parse("PT1.5S") != IsoDurationValue(
        Span(), Duration.from_milliseconds(1500)
    ):
        print("FAIL parse fractional")
        f += 1
    # 'M' is months before T, minutes after T
    if IsoDuration.parse("P3MT15M") != IsoDurationValue(
        Span(0, 3, 0), Duration.from_seconds(900)
    ):
        print("FAIL parse M ambiguity")
        f += 1

    # --- round-trip ---
    var v = IsoDuration.format(Span(2, 0, 10), Duration.from_seconds(3661))
    if IsoDuration.parse(v) != IsoDurationValue(
        Span(2, 0, 10), Duration.from_seconds(3661)
    ):
        print("FAIL round-trip")
        f += 1

    # --- malformed rejection ---
    var raised = False
    try:
        _ = IsoDuration.parse("1Y")  # missing P
    except:
        raised = True
    if not raised:
        print("FAIL accepted missing P")
        f += 1
    raised = False
    try:
        _ = IsoDuration.parse("P5")  # number without designator
    except:
        raised = True
    if not raised:
        print("FAIL accepted number without designator")
        f += 1
    # ISO 8601 §5.5.2 — these inputs silently lost data before the strict
    # parse; they must raise now. Last two rows guard against Int64 overflow
    # in the digit accumulator (DoS via a multi-MB number).
    var strict_rejects = [
        "P1.5Y",  # fractional only allowed on smallest used component
        "P0.5M",  # ditto in month slot
        "P1D2M",  # out-of-order designators
        "P1Y2Y",  # duplicate designator
        "PT5S1H",  # time designators out of order
        "P1W1D",  # week form mutually exclusive with D
        "P1Y1W",  # week form mutually exclusive with Y
        "P1WT1H",  # week form mutually exclusive with time part
        "P9999999999999999999Y",  # int accumulator overflow
        "PT0.123456789012345678901234567890123S",  # too many fractional digits
        "PY",  # designator with no preceding value -> "missing component value"
        "PT",  # 'T' switch then nothing -> "missing component value"
    ]
    for i in range(len(strict_rejects)):
        raised = False
        try:
            _ = IsoDuration.parse(strict_rejects[i])
        except:
            raised = True
        if not raised:
            print("FAIL strict-reject not raised:", strict_rejects[i])
            f += 1

    # ISO 8601-1 has no representation for a negative duration (8601-2's
    # `-P...` sign-before-P is not produced here either). Format must raise
    # rather than emit non-conformant `"P-2Y"` or floor-decomposed `"PT-1H"`.
    raised = False
    try:
        _ = IsoDuration.format(Span(-2, 0, 0), Duration.ZERO)
    except:
        raised = True
    if not raised:
        print("FAIL accepted negative Span in format")
        f += 1
    raised = False
    try:
        _ = IsoDuration.format(Span(), Duration.from_seconds(-3600))
    except:
        raised = True
    if not raised:
        print("FAIL accepted negative Duration in format")
        f += 1

    if f == 0:
        print("test_iso_duration: PASS")
    return f
