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
from chrono._core.units import SECONDS_PER_HOUR, SECONDS_PER_MINUTE
from chrono._internal.text import (
    pad,
    fractional_seconds,
    fold_leap_second,
    format_offset_hhmm,
)
from chrono._internal.itoa import write2, write4, write_n_digits_padded
from chrono._internal.scanner import Scanner


struct Rfc3339:
    @staticmethod
    def format(datetime: DateTime, offset: Offset) raises -> String:
        # Single-allocation fast path: pre-compute the exact output length,
        # allocate one String, write the 19 fixed bytes + variable fractional
        # + 1 or 6 byte zone via direct pointer writes. Two-digit lookup
        # avoids the divide/mod-plus-add pair per field.
        # One pass over `_days_since_epoch` for the date components; the time
        # accessors are each a single divide on a packed `_nanoseconds_since_
        # midnight`, so calling them separately is fine (LLVM CSE's the divide).
        var ymd = datetime.date().year_month_day()
        var year = ymd.year
        if year < 0 or year > 9999:
            raise Error("chrono.Rfc3339: year out of RFC 3339 range (0..9999)")
        var month = ymd.month
        var day = ymd.day
        var hour = datetime.hour()
        var minute = datetime.minute()
        var second = datetime.second()
        var nanos = datetime.nanosecond()

        # Fractional precision — trim trailing zeros to match `fractional_seconds`.
        var frac_digits = 0
        var frac_value = 0
        if nanos != 0:
            frac_digits = 9
            var n = nanos
            while (n % 10) == 0:
                n //= 10
                frac_digits -= 1
            frac_value = n

        var zone_len = 1 if offset.is_utc() else 6
        var frac_len = (1 + frac_digits) if frac_digits > 0 else 0
        var total = 19 + frac_len + zone_len

        var s = String(unsafe_uninit_length=total)
        var p = s.unsafe_ptr_mut()

        write4(p, 0, year)
        p[4] = UInt8(ord("-"))
        write2(p, 5, month)
        p[7] = UInt8(ord("-"))
        write2(p, 8, day)
        p[10] = UInt8(ord("T"))
        write2(p, 11, hour)
        p[13] = UInt8(ord(":"))
        write2(p, 14, minute)
        p[16] = UInt8(ord(":"))
        write2(p, 17, second)

        var off = 19
        if frac_digits > 0:
            p[off] = UInt8(ord("."))
            write_n_digits_padded(p, off + 1, frac_value, frac_digits)
            off += 1 + frac_digits

        if offset.is_utc():
            p[off] = UInt8(ord("Z"))
        else:
            var sec = offset.total_seconds()
            if sec >= 0:
                p[off] = UInt8(ord("+"))
            else:
                p[off] = UInt8(ord("-"))
                sec = -sec
            write2(p, off + 1, sec // SECONDS_PER_HOUR)
            p[off + 3] = UInt8(ord(":"))
            write2(p, off + 4, (sec % SECONDS_PER_HOUR) // SECONDS_PER_MINUTE)

        return s^

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
