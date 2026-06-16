# Date — a civil (proleptic Gregorian) calendar date, the date half of the naive
# *view*. Stored as a single Int32 day count since 1970-01-01, so comparison and
# day-stepping are integer ops (and a column of Dates is SIMD-friendly); the
# year/month/day fields are decoded on demand via the verified `_core/civil` core.
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: from spec; the civil seam is verified differential vs Python `datetime`.

from chrono._core.civil import (
    days_since_epoch_from_date,
    date_from_days_since_epoch,
    iso_weekday_from_days_since_epoch,
    add_months_to_year_month,
    is_leap_year,
    days_in_month,
    YearMonthDay,
)
from chrono.enums import Weekday, Month
from chrono.span import Span

from chrono._core.units import INT32_MIN, INT32_MAX


struct Date(Comparable, TrivialRegisterPassable):
    var _days_since_epoch: Int32

    @always_inline
    def __init__(out self, *, days_since_epoch: Int32):
        """Internal: construct directly from the day count."""
        self._days_since_epoch = days_since_epoch

    def __init__(out self, year: Int, month: Int, day: Int) raises:
        """Validating construction; raises on an out-of-range field."""
        if month < 1 or month > 12:
            raise Error(
                "chrono.Date: month out of range (1..12), got " + String(month)
            )
        if day < 1 or day > days_in_month(year, month):
            raise Error(
                "chrono.Date: day out of range for "
                + String(year)
                + "-"
                + String(month)
                + " (1.."
                + String(days_in_month(year, month))
                + "), got "
                + String(day)
            )
        var count = days_since_epoch_from_date(year, month, day)
        if count < INT32_MIN or count > INT32_MAX:
            raise Error(
                "chrono.Date: year "
                + String(year)
                + " out of representable range"
            )
        self._days_since_epoch = Int32(count)

    @staticmethod
    def from_days_since_epoch(days: Int) raises -> Self:
        if days < INT32_MIN or days > INT32_MAX:
            raise Error(
                "chrono.Date: day count out of Int32 range, got " + String(days)
            )
        return Self(days_since_epoch=Int32(days))

    @always_inline
    def year(self) -> Int:
        return date_from_days_since_epoch(Int(self._days_since_epoch)).year

    @always_inline
    def month(self) -> Month:
        return Month(
            raw=UInt8(
                date_from_days_since_epoch(Int(self._days_since_epoch)).month
            )
        )

    @always_inline
    def day(self) -> Int:
        return date_from_days_since_epoch(Int(self._days_since_epoch)).day

    @always_inline
    def year_month_day(self) -> YearMonthDay:
        return date_from_days_since_epoch(Int(self._days_since_epoch))

    @always_inline
    def weekday(self) -> Weekday:
        return Weekday(
            raw=UInt8(
                iso_weekday_from_days_since_epoch(Int(self._days_since_epoch))
            )
        )

    def day_of_year(self) -> Int:
        var ymd = self.year_month_day()
        return (
            Int(self._days_since_epoch)
            - days_since_epoch_from_date(ymd.year, 1, 1)
            + 1
        )

    @always_inline
    def is_leap_year(self) -> Bool:
        return is_leap_year(self.year())

    @always_inline
    def days_since_epoch(self) -> Int:
        return Int(self._days_since_epoch)

    def plus_days(self, days: Int) raises -> Self:
        """Step `days` forward. Computed in 64-bit and range-checked, so it neither
        truncates a large `days` nor wraps the Int32 storage (it raises instead)."""
        return Date.from_days_since_epoch(self.days_since_epoch() + days)

    def minus_days(self, days: Int) raises -> Self:
        return Date.from_days_since_epoch(self.days_since_epoch() - days)

    def plus_span(self, span: Span) raises -> Self:
        """Add a calendar Span: years+months first (clamping the day to the end of
        the target month), then days. Raises if the result leaves Date's range."""
        var ymd = self.year_month_day()
        var shifted = add_months_to_year_month(
            ymd.year, ymd.month, span.years() * 12 + span.months()
        )
        var max_day = days_in_month(shifted.year, shifted.month)
        var new_day = ymd.day if ymd.day <= max_day else max_day  # clamp
        return Date(shifted.year, shifted.month, new_day).plus_days(span.days())

    def minus_span(self, span: Span) raises -> Self:
        return self.plus_span(-span)

    @always_inline
    def __sub__(self, other: Self) -> Int:
        """Number of days between two dates."""
        return Int(self._days_since_epoch) - Int(other._days_since_epoch)

    # --- comparison (delegates to the single Int32 field) ---

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._days_since_epoch == other._days_since_epoch

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        return self._days_since_epoch < other._days_since_epoch

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self < other or self == other

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return not (self <= other)

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return not (self < other)
