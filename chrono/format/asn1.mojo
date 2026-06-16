# Asn1Time — ASN.1 / DER time strings used by X.509 certificate validity:
#   UTCTime          "YYMMDDHHMMSSZ"            (2-digit year, UTC, seconds present)
#   GeneralizedTime  "YYYYMMDDHHMMSS[.fff]Z"    (4-digit year, optional fraction)
# Both are UTC (Z-terminated) in the DER profile, so they map to a naive DateTime
# understood as UTC. The X.509 YY pivot (RFC 5280 §4.1.2.5.1): 00..49 -> 20YY,
# 50..99 -> 19YY, i.e. UTCTime covers 1950..2049.
#
# Facets: tier T0 (spine, feeds crypto X.509) | safety sound (bounds-checked) | quantum n/a.
# Honesty: from spec (X.680 / X.690 DER + RFC 5280). KAT + round-trip. DER forbids
# the leap-second representation (X.690 §11.7), so a `:60` second is REJECTED on
# parse — every other chrono format folds it at 23:59 UTC, but DER is stricter.
# Independent format unit (own small pad/digit helpers).

from chrono.datetime import DateTime
from chrono._internal.text import (
    pad,
    fractional_seconds,
    range_error,
    reject_leap_second,
)
from chrono._internal.scanner import Scanner


struct Asn1Time:
    @staticmethod
    def format_utc_time(datetime: DateTime) raises -> String:
        var year = datetime.year()
        if year < 1950 or year > 2049:
            raise range_error("Asn1Time", "UTCTime year", year, 1950, 2049)
        # UTCTime has no fractional component (X.680 §47). Folding a non-zero
        # nanosecond silently would let `2026-06-15T14:30:45.5 -> "...45Z"`
        # round-trip lose half a second; X.509 byte-exact validation would
        # break the moment a peer encoded it back at full precision.
        if datetime.nanosecond() != 0:
            raise Error(
                "chrono.Asn1Time: UTCTime has no fractional component; got "
                + String(datetime.nanosecond())
                + " ns — use format_generalized_time instead"
            )
        var s = pad(year % 100, 2)
        s += pad(datetime.month().number(), 2) + pad(datetime.day(), 2)
        s += pad(datetime.hour(), 2) + pad(datetime.minute(), 2)
        s += pad(datetime.second(), 2) + "Z"
        return s

    @staticmethod
    def parse_utc_time(text: String) raises -> DateTime:
        var scanner = Scanner(text)
        var two_digit_year = scanner.take_int(2)
        # RFC 5280 §4.1.2.5.1 pivot: 00..49 -> 20YY, 50..99 -> 19YY.
        var year = (2000 + two_digit_year) if two_digit_year < 50 else (
            1900 + two_digit_year
        )
        var month = scanner.take_int(2)
        var day = scanner.take_int(2)
        var hour = scanner.take_int(2)
        var minute = scanner.take_int(2)
        var second = scanner.take_int(2)
        scanner.expect("Z")
        if not scanner.is_at_end():
            raise Error("chrono.Asn1Time: trailing data after UTCTime")
        reject_leap_second("Asn1Time", "UTCTime", second)
        return DateTime(year, month, day, hour, minute, second)

    @staticmethod
    def format_generalized_time(datetime: DateTime) raises -> String:
        var year = datetime.year()
        if year < 0 or year > 9999:
            raise Error("chrono.Asn1Time: GeneralizedTime year must be 0..9999")
        var s = pad(year, 4)
        s += pad(datetime.month().number(), 2) + pad(datetime.day(), 2)
        s += pad(datetime.hour(), 2) + pad(datetime.minute(), 2)
        s += pad(datetime.second(), 2)
        s += fractional_seconds(datetime.nanosecond()) + "Z"
        return s

    @staticmethod
    def parse_generalized_time(text: String) raises -> DateTime:
        var scanner = Scanner(text)
        var year = scanner.take_int(4)
        var month = scanner.take_int(2)
        var day = scanner.take_int(2)
        var hour = scanner.take_int(2)
        var minute = scanner.take_int(2)
        var second = scanner.take_int(2)
        var nanosecond = 0
        if scanner.accept("."):
            # X.690 §11.7.4: DER canonical fraction has no trailing zeros and
            # `.0` itself is forbidden (the whole `.frac` block is omitted
            # when the value is zero).
            nanosecond = scanner.take_fraction_nanoseconds(
                strict_no_trailing_zero=True
            )
        scanner.expect("Z")
        if not scanner.is_at_end():
            raise Error("chrono.Asn1Time: trailing data after GeneralizedTime")
        reject_leap_second("Asn1Time", "GeneralizedTime", second)
        return DateTime(year, month, day, hour, minute, second, nanosecond)
