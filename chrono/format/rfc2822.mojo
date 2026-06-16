# RFC 5322 (email) and RFC 7231 (HTTP) date formats — the human-readable,
# named-day/month style:
#   HttpDate  "Mon, 15 Jun 2026 14:30:45 GMT"    (IMF-fixdate; always UTC/GMT)
#   Rfc2822   "Mon, 15 Jun 2026 14:30:45 +0700"  (with a numeric offset)
# Parsing accepts the strict canonical form these emit (fixed positions).
#
# Facets: tier T0 (spine, feeds http/email) | safety sound (bounds-checked) | quantum n/a.
# Honesty: from spec (RFC 5322 / RFC 7231). Format differential vs Python
# `email.utils`; parse is strict (obsolete/lenient forms are not accepted). The
# `Wkd,` prefix is verified against the date — a parsed `Fri, 15 Jun 2026` (a
# Monday) raises, since RFC 5322 §3.3 requires the weekday label to match.

from chrono.datetime import DateTime
from chrono.enums import Month, Weekday
from chrono.offset import Offset
from chrono.offset_datetime import OffsetDateTime
from chrono._internal.text import (
    pad,
    fold_leap_second,
    format_offset_hhmm,
    range_error,
)
from chrono._internal.scanner import Scanner


struct _Prefix(Copyable, Movable):
    """Raw 'Wkd, DD Mon YYYY HH:MM:SS' fields — parsed but not yet folded or
    built into a DateTime, so the caller can resolve the leap-second window
    against the *trailing* offset (which RFC 5322 places after the seconds)."""

    var weekday: Weekday
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var minute: Int
    var second_raw: Int

    def __init__(
        out self,
        weekday: Weekday,
        year: Int,
        month: Int,
        day: Int,
        hour: Int,
        minute: Int,
        second_raw: Int,
    ):
        self.weekday = weekday
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second_raw = second_raw

    def into_datetime(self, *, offset_seconds: Int) raises -> DateTime:
        """Fold the leap second against `offset_seconds`, build the DateTime,
        and verify the parsed weekday matches the resolved date (RFC 5322 §3.3
        requires the weekday label be consistent with the date)."""
        var second = fold_leap_second(
            self.hour,
            self.minute,
            self.second_raw,
            offset_seconds=offset_seconds,
        )
        var datetime = DateTime(
            self.year, self.month, self.day, self.hour, self.minute, second
        )
        if datetime.weekday() != self.weekday:
            raise Error(
                "chrono.Rfc2822: weekday label '"
                + String(self.weekday.name())[byte=0:3]
                + "' disagrees with date "
                + String(self.year)
                + "-"
                + pad(self.month, 2)
                + "-"
                + pad(self.day, 2)
                + " (a "
                + String(datetime.weekday().name())
                + ")"
            )
        return datetime


def _format_prefix(datetime: DateTime) raises -> String:
    """ "Wkd, DD Mon YYYY HH:MM:SS" — shared by HttpDate and Rfc2822."""
    var year = datetime.year()
    if year < 0 or year > 9999:
        raise range_error("Rfc2822", "year", year, 0, 9999)
    var s = String(datetime.weekday().name())[byte=0:3] + ", "
    s += pad(datetime.day(), 2) + " "
    s += String(datetime.month().name())[byte=0:3] + " "
    s += pad(year, 4) + " "
    s += pad(datetime.hour(), 2) + ":" + pad(datetime.minute(), 2)
    s += ":" + pad(datetime.second(), 2)
    return s


def _parse_prefix(mut scanner: Scanner) raises -> _Prefix:
    """Consume the "Wkd, DD Mon YYYY HH:MM:SS" head and return its raw fields;
    the caller folds the leap second once the offset is known and verifies the
    weekday against the constructed DateTime."""
    var weekday = Weekday.from_name(scanner.take_text(3), prefix_len=3)
    scanner.expect(",")
    scanner.expect(" ")
    var day = scanner.take_int(2)
    scanner.expect(" ")
    var month = Month.from_name(scanner.take_text(3), prefix_len=3)
    scanner.expect(" ")
    var year = scanner.take_int(4)
    scanner.expect(" ")
    var hour = scanner.take_int(2)
    scanner.expect(":")
    var minute = scanner.take_int(2)
    scanner.expect(":")
    var second_raw = scanner.take_int(2)
    return _Prefix(weekday, year, month.number(), day, hour, minute, second_raw)


struct HttpDate:
    @staticmethod
    def format(datetime: DateTime) raises -> String:
        return _format_prefix(datetime) + " GMT"

    @staticmethod
    def parse(text: String) raises -> DateTime:
        var scanner = Scanner(text)
        var prefix = _parse_prefix(scanner)
        scanner.expect(" ")
        if scanner.take_text(3) != "GMT" or not scanner.is_at_end():
            raise Error("chrono.HttpDate: must end in ' GMT'")
        # GMT is +00:00, so the leap-second window is the UTC one.
        return prefix.into_datetime(offset_seconds=0)


struct Rfc2822:
    @staticmethod
    def format(offset_datetime: OffsetDateTime) raises -> String:
        var s = _format_prefix(offset_datetime.datetime()) + " "
        s += format_offset_hhmm(
            offset_datetime.offset().total_seconds(), colon=False
        )
        return s

    @staticmethod
    def parse(text: String) raises -> OffsetDateTime:
        var scanner = Scanner(text)
        var prefix = _parse_prefix(scanner)
        scanner.expect(" ")
        var offset = Offset.from_seconds(
            scanner.take_offset_hhmm(with_colon=False)
        )
        if not scanner.is_at_end():
            raise Error("chrono.Rfc2822: trailing data after offset")
        return OffsetDateTime(
            prefix.into_datetime(offset_seconds=offset.total_seconds()),
            offset,
        )
