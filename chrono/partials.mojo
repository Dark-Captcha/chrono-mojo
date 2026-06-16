# Partial civil values (Temporal-style):
#   YearMonth — a year + month, no day (billing months, card expiry).
#   MonthDay  — a month + day, no year (birthdays, anniversaries, holidays).
# MonthDay accepts Feb 29 (a valid leap-day); whether it lands in a given year is
# answered by is_valid_in_year / at_year.
#
# Facets: tier T0 (spine) | safety sound (validating) | quantum n/a.
# Honesty: from spec; KAT-verified.

from chrono._core.civil import (
    days_in_month,
    add_months_to_year_month,
    days_since_epoch_from_date,
)
from chrono.date import Date
from chrono.enums import Month

from chrono._core.units import INT32_MIN, INT32_MAX


struct YearMonth(Comparable, TrivialRegisterPassable):
    var _year: Int32
    var _month: UInt8  # 1..12

    def __init__(out self, year: Int, month: Int) raises:
        if month < 1 or month > 12:
            raise Error(
                "chrono.YearMonth: month out of range (1..12), got "
                + String(month)
            )
        if year < INT32_MIN or year > INT32_MAX:
            raise Error(
                "chrono.YearMonth: year out of representable range, got "
                + String(year)
            )
        self._year = Int32(year)
        self._month = UInt8(month)

    @always_inline
    def year(self) -> Int:
        return Int(self._year)

    @always_inline
    def month(self) -> Month:
        return Month(raw=self._month)

    @always_inline
    def length_of_month(self) -> Int:
        return days_in_month(Int(self._year), Int(self._month))

    @always_inline
    def first_day(self) -> Date:
        """The 1st of this YearMonth as a Date. Cannot fail: the YearMonth's
        own ctor already validated (year, month) in range."""
        return Date(
            days_since_epoch=Int32(
                days_since_epoch_from_date(Int(self._year), Int(self._month), 1)
            )
        )

    @always_inline
    def last_day(self) -> Date:
        """The last calendar day of this YearMonth (28/29/30/31)."""
        return Date(
            days_since_epoch=Int32(
                days_since_epoch_from_date(
                    Int(self._year),
                    Int(self._month),
                    self.length_of_month(),
                )
            )
        )

    def at_day(self, day: Int) raises -> Date:
        return Date(Int(self._year), Int(self._month), day)

    def plus_months(self, months: Int) raises -> Self:
        var shifted = add_months_to_year_month(
            Int(self._year), Int(self._month), months
        )
        return YearMonth(shifted.year, shifted.month)

    def minus_months(self, months: Int) raises -> Self:
        return self.plus_months(-months)

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._year == other._year and self._month == other._month

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        if self._year != other._year:
            return self._year < other._year
        return self._month < other._month

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self < other or self == other

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return not (self <= other)

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return not (self < other)


struct MonthDay(Comparable, TrivialRegisterPassable):
    var _month: UInt8  # 1..12
    var _day: UInt8  # 1..31 (Feb allows 29)

    def __init__(out self, month: Int, day: Int) raises:
        if month < 1 or month > 12:
            raise Error(
                "chrono.MonthDay: month out of range (1..12), got "
                + String(month)
            )
        # 2000 is a leap year, so Feb 29 is accepted as a valid month-day.
        if day < 1 or day > days_in_month(2000, month):
            raise Error(
                "chrono.MonthDay: day out of range for month "
                + String(month)
                + " (1.."
                + String(days_in_month(2000, month))
                + "), got "
                + String(day)
            )
        self._month = UInt8(month)
        self._day = UInt8(day)

    @always_inline
    def month(self) -> Month:
        return Month(raw=self._month)

    @always_inline
    def day(self) -> Int:
        return Int(self._day)

    @always_inline
    def is_valid_in_year(self, year: Int) -> Bool:
        return Int(self._day) <= days_in_month(year, Int(self._month))

    def at_year(self, year: Int) raises -> Date:
        return Date(year, Int(self._month), Int(self._day))

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._month == other._month and self._day == other._day

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        if self._month != other._month:
            return self._month < other._month
        return self._day < other._day

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self < other or self == other

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return not (self <= other)

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return not (self < other)
