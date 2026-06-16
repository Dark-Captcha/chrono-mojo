# Rfc3339 — parse and format Internet timestamps (RFC 3339, a profile of ISO 8601).
# An independent unit depending only on the value types, so DateTime/OffsetDateTime
# stay decoupled from serialization. `parse` yields an OffsetDateTime (the moment +
# its offset).
#
# Facets: tier T0 (spine) | safety sound (bounds-checked parse) | quantum n/a.
# Honesty: from the RFC 3339 ABNF. Format is KAT; parse / parse_to_instant are
# differential vs Python `datetime`. A leap second (`:60`) is accepted ONLY at
# 23:59 UTC (RFC 3339 §5.6) and folded to `:59`; anywhere else it raises (chrono
# does not silently rewrite the input). `format` raises for a year outside 0..9999
# (RFC 3339 is 4-digit; no silent garbage).

from chrono.datetime import DateTime
from chrono.offset import Offset
from chrono.offset_datetime import OffsetDateTime
from chrono.instant import Instant
from chrono._core.clock_id import ClockId
from chrono.duration import Duration
from chrono._internal.text import (
    pad,
    fractional_seconds,
    fold_leap_second,
    format_offset_hhmm,
)
from chrono._internal.scanner import Scanner


struct Rfc3339:
    @staticmethod
    def format(datetime: DateTime, offset: Offset) raises -> String:
        var year = datetime.year()
        if year < 0 or year > 9999:
            raise Error("chrono.Rfc3339: year out of RFC 3339 range (0..9999)")
        var s = pad(year, 4)
        s += "-" + pad(datetime.month().number(), 2)
        s += "-" + pad(datetime.day(), 2)
        s += "T" + pad(datetime.hour(), 2)
        s += ":" + pad(datetime.minute(), 2)
        s += ":" + pad(datetime.second(), 2)
        s += fractional_seconds(datetime.nanosecond())
        if offset.is_utc():
            s += "Z"
        else:
            s += format_offset_hhmm(offset.total_seconds(), colon=True)
        return s

    @staticmethod
    def format(offset_datetime: OffsetDateTime) raises -> String:
        return Rfc3339.format(
            offset_datetime.datetime(), offset_datetime.offset()
        )

    @staticmethod
    def parse(text: String) raises -> OffsetDateTime:
        var scanner = Scanner(text)
        var year = scanner.take_int(4)
        scanner.expect("-")
        var month = scanner.take_int(2)
        scanner.expect("-")
        var day = scanner.take_int(2)
        # date/time separator: 'T' (or lower-case 't', or a space)
        if not (
            scanner.accept("T") or scanner.accept("t") or scanner.accept(" ")
        ):
            raise Error("chrono.Rfc3339: bad date/time separator")
        var hour = scanner.take_int(2)
        scanner.expect(":")
        var minute = scanner.take_int(2)
        scanner.expect(":")
        var second = scanner.take_int(2)

        var nanosecond = 0
        if scanner.accept("."):
            nanosecond = scanner.take_fraction_nanoseconds()

        var offset = Offset.UTC
        if not (scanner.accept("Z") or scanner.accept("z")):
            # `-00:00` is RFC 3339 §4.3 "offset unknown"; chrono has no
            # representation for that, so reject it (rather than silently
            # collapse to +00:00). Per-component range checks (HH < 24,
            # MM < 60) live in the scanner helper.
            offset = Offset.from_seconds(
                scanner.take_offset_hhmm(
                    with_colon=True, forbid_negative_zero=True
                )
            )
        if not scanner.is_at_end():
            raise Error(
                "chrono.Rfc3339: trailing data after timestamp at position "
                + String(scanner.position())
            )

        # RFC 3339 §5.6: ':60' is only valid at 23:59 UTC — `fold_leap_second`
        # enforces both the wall-clock window AND the zero-offset requirement.
        second = fold_leap_second(
            hour, minute, second, offset_seconds=offset.total_seconds()
        )
        return OffsetDateTime(
            DateTime(year, month, day, hour, minute, second, nanosecond), offset
        )

    @staticmethod
    def parse_to_instant(text: String) raises -> Instant[ClockId.REALTIME]:
        return Rfc3339.parse(text).to_instant()
