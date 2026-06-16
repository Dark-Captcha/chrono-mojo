# Asn1Time: UTCTime + GeneralizedTime format/parse (KAT + round-trip), the X.509 YY
# pivot, fractional seconds, and malformed/range rejection.

from chrono.format.asn1 import Asn1Time
from chrono.datetime import DateTime


def run() raises -> Int:
    var f = 0

    # --- UTCTime ---
    if (
        Asn1Time.format_utc_time(DateTime(2026, 6, 15, 14, 30, 45))
        != "260615143045Z"
    ):
        print("FAIL format_utc_time")
        f += 1
    if Asn1Time.parse_utc_time("260615143045Z") != DateTime(
        2026, 6, 15, 14, 30, 45
    ):
        print("FAIL parse_utc_time")
        f += 1
    # YY pivot: 00..49 -> 20YY, 50..99 -> 19YY (RFC 5280 §4.1.2.5.1).
    # Boundaries — the exact pivot edges PLUS the 0 and 99 ends.
    if Asn1Time.parse_utc_time("000101000000Z") != DateTime(
        2000, 1, 1, 0, 0, 0
    ):
        print("FAIL UTCTime pivot 00->2000")
        f += 1
    if Asn1Time.parse_utc_time("490101000000Z") != DateTime(
        2049, 1, 1, 0, 0, 0
    ):
        print("FAIL UTCTime pivot 49->2049")
        f += 1
    if Asn1Time.parse_utc_time("500101000000Z") != DateTime(
        1950, 1, 1, 0, 0, 0
    ):
        print("FAIL UTCTime pivot 50->1950")
        f += 1
    if Asn1Time.parse_utc_time("991231235959Z") != DateTime(
        1999, 12, 31, 23, 59, 59
    ):
        print("FAIL UTCTime pivot 99->1999")
        f += 1

    # --- GeneralizedTime ---
    if (
        Asn1Time.format_generalized_time(DateTime(2026, 6, 15, 14, 30, 45))
        != "20260615143045Z"
    ):
        print("FAIL format_generalized_time")
        f += 1
    if (
        Asn1Time.format_generalized_time(
            DateTime(2026, 6, 15, 14, 30, 45, 500_000_000)
        )
        != "20260615143045.5Z"
    ):
        print("FAIL format_generalized_time fractional")
        f += 1
    if Asn1Time.parse_generalized_time("20260615143045Z") != DateTime(
        2026, 6, 15, 14, 30, 45
    ):
        print("FAIL parse_generalized_time")
        f += 1
    if Asn1Time.parse_generalized_time("20260615143045.5Z") != DateTime(
        2026, 6, 15, 14, 30, 45, 500_000_000
    ):
        print("FAIL parse_generalized_time fractional")
        f += 1
    # Full 9-digit nanosecond precision must round-trip through parse.
    if (
        Asn1Time.parse_generalized_time(
            "20260615143045.123456789Z"
        ).nanosecond()
        != 123_456_789
    ):
        print("FAIL GeneralizedTime nanosecond precision")
        f += 1
    # GeneralizedTime covers years UTCTime cannot
    if (
        Asn1Time.format_generalized_time(DateTime(1900, 1, 1, 0, 0, 0))
        != "19000101000000Z"
    ):
        print("FAIL GeneralizedTime 1900")
        f += 1
    if Asn1Time.parse_generalized_time("19000101000000Z") != DateTime(
        1900, 1, 1, 0, 0, 0
    ):
        print("FAIL parse GeneralizedTime 1900")
        f += 1

    # --- range / malformed rejection ---
    var raised = False
    try:
        _ = Asn1Time.format_utc_time(
            DateTime(2050, 1, 1, 0, 0, 0)
        )  # out of 1950..2049
    except:
        raised = True
    if not raised:
        print("FAIL UTCTime accepted year 2050")
        f += 1
    raised = False
    try:
        _ = Asn1Time.parse_utc_time("260615143045")  # missing Z
    except:
        raised = True
    if not raised:
        print("FAIL UTCTime accepted missing Z")
        f += 1
    raised = False
    try:
        _ = Asn1Time.parse_generalized_time("20260615143045")  # missing Z
    except:
        raised = True
    if not raised:
        print("FAIL GeneralizedTime accepted missing Z")
        f += 1
    # DER does NOT permit a leap second ':60' in either UTCTime or
    # GeneralizedTime (ITU-T X.690 §11.7 / RFC 5280 §4.1.2.5).
    raised = False
    try:
        _ = Asn1Time.parse_utc_time("161231235960Z")
    except:
        raised = True
    if not raised:
        print("FAIL UTCTime accepted leap second")
        f += 1
    raised = False
    try:
        _ = Asn1Time.parse_generalized_time("20161231235960Z")
    except:
        raised = True
    if not raised:
        print("FAIL GeneralizedTime accepted leap second")
        f += 1

    # Lower-rail UTCTime: 1949 is below the 1950..2049 window.
    raised = False
    try:
        _ = Asn1Time.format_utc_time(DateTime(1949, 12, 31, 23, 59, 59))
    except:
        raised = True
    if not raised:
        print("FAIL UTCTime accepted year 1949")
        f += 1

    # UTCTime has no fractional component (X.680 §47): formatting a datetime
    # with non-zero nanoseconds must raise, not silently truncate. The audit
    # defect was a half-second silently round-tripping away.
    raised = False
    try:
        _ = Asn1Time.format_utc_time(
            DateTime(2026, 6, 15, 14, 30, 45, 500_000_000)
        )
    except:
        raised = True
    if not raised:
        print("FAIL UTCTime accepted non-zero nanosecond")
        f += 1

    # X.690 §11.7.4 DER canonical encoding: the GeneralizedTime fraction must
    # NOT have trailing zeros, and `.0` itself is forbidden (omit the whole
    # `.frac` block when the value is zero). Without this check, two DER
    # encodings (`.5Z` vs `.500Z`) would parse to the same DateTime, breaking
    # X.509 byte-exact validation.
    raised = False
    try:
        _ = Asn1Time.parse_generalized_time("20260615143045.500Z")
    except:
        raised = True
    if not raised:
        print("FAIL GeneralizedTime accepted trailing-zero fraction")
        f += 1
    raised = False
    try:
        _ = Asn1Time.parse_generalized_time("20260615143045.0Z")
    except:
        raised = True
    if not raised:
        print("FAIL GeneralizedTime accepted `.0` fraction")
        f += 1

    if f == 0:
        print("test_asn1: PASS")
    return f
