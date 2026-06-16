# Proleptic Gregorian civil-date arithmetic — Howard Hinnant's algorithms
# (chrono-Compatible Low-Level Date Algorithms, 2021), implemented from spec.
#
# Day 0 is 1970-01-01 (the Unix epoch). Mojo's `//` is floor division
# (`-7 // 400 == -1`), so the 400-year era split needs no
# truncation-compensation — `year // 400` already floors, giving the
# year-of-era in [0, 399] for every year, including negative (proleptic) ones.
#
# Facets: tier T0 (spine) | safety sound (total integer arithmetic) | quantum n/a.
# Honesty: from spec, not ported. Verified by differential vs Python datetime
# (year >= 1) + round-trip property tests (incl. proleptic year < 1).

from chrono._core.units import (
    DAYS_PER_ERA,
    EPOCH_SHIFT_DAYS,
    MONTHS_PER_YEAR,
    DAYS_PER_WEEK,
)


struct YearMonthDay(Equatable, TrivialRegisterPassable):
    """A civil (proleptic Gregorian) year/month/day triple: `month` is 1..12,
    `day` is 1..31. Used as a return value in place of a tuple."""

    var year: Int
    var month: Int
    var day: Int

    @always_inline
    def __init__(out self, year: Int, month: Int, day: Int):
        self.year = year
        self.month = month
        self.day = day

    def __eq__(self, other: Self) -> Bool:
        return (
            self.year == other.year
            and self.month == other.month
            and self.day == other.day
        )

    def __ne__(self, other: Self) -> Bool:
        return not (self == other)


@always_inline
def is_leap_year(year: Int) -> Bool:
    """Proleptic Gregorian leap rule. Floor `%` keeps it correct for year < 1."""
    return (year % 4 == 0 and year % 100 != 0) or year % 400 == 0


@always_inline
def days_in_month(year: Int, month: Int) -> Int:
    """Length of `month` (1..12) in `year`. The caller guarantees a valid month."""
    if month == 2:
        return 29 if is_leap_year(year) else 28
    if month == 4 or month == 6 or month == 9 or month == 11:
        return 30
    return 31


@always_inline
def days_since_epoch_from_date(year: Int, month: Int, day: Int) -> Int:
    """Serial day number (days since 1970-01-01) of a civil date. Hinnant's
    `days_from_civil`, in floor-division form (no sign adjustment needed)."""
    var shifted_year = (
        year - 1
    ) if month <= 2 else year  # Jan/Feb -> prior year
    var era = shifted_year // 400
    var year_of_era = shifted_year - era * 400  # [0, 399]
    var month_index = (month - 3) if month > 2 else (month + 9)  # March = 0
    var day_of_year = (153 * month_index + 2) // 5 + (day - 1)  # [0, 365]
    var day_of_era = (
        year_of_era * 365 + year_of_era // 4 - year_of_era // 100 + day_of_year
    )  # [0, 146096]
    return era * DAYS_PER_ERA + day_of_era - EPOCH_SHIFT_DAYS


@always_inline
def date_from_days_since_epoch(days: Int) -> YearMonthDay:
    """Civil date of a serial day number. Hinnant's `civil_from_days`, floor form."""
    var shifted = days + EPOCH_SHIFT_DAYS
    var era = shifted // DAYS_PER_ERA
    var day_of_era = shifted - era * DAYS_PER_ERA  # [0, 146096]
    var year_of_era = (
        day_of_era
        - day_of_era // 1460
        + day_of_era // 36524
        - day_of_era // 146096
    ) // 365  # [0, 399]
    var shifted_year = year_of_era + era * 400
    var day_of_year = day_of_era - (
        365 * year_of_era + year_of_era // 4 - year_of_era // 100
    )  # [0, 365]
    var month_index = (5 * day_of_year + 2) // 153  # [0, 11]
    var day = day_of_year - (153 * month_index + 2) // 5 + 1  # [1, 31]
    var month = (month_index + 3) if month_index < 10 else (month_index - 9)
    return YearMonthDay(
        (shifted_year + 1) if month <= 2 else shifted_year, month, day
    )


@always_inline
def add_months_to_year_month(year: Int, month: Int, delta: Int) -> YearMonthDay:
    """`(year, month 1..12)` shifted by `delta` months, floor-normalized; day = 1.
    The single home for the year*12 + month folding used by Date/Span and YearMonth."""
    var total = year * MONTHS_PER_YEAR + (month - 1) + delta
    return YearMonthDay(
        total // MONTHS_PER_YEAR, total % MONTHS_PER_YEAR + 1, 1
    )


@always_inline
def weekday_from_days_since_epoch(days: Int) -> Int:
    """Day of week, 0 = Sunday .. 6 = Saturday. Day 0 (1970-01-01) is Thursday (4).
    Floor `%` makes this single expression total over negative days."""
    return (days + 4) % DAYS_PER_WEEK


@always_inline
def iso_weekday_from_days_since_epoch(days: Int) -> Int:
    """Day of week in ISO numbering, 1 = Monday .. 7 = Sunday."""
    var civil = (days + 4) % DAYS_PER_WEEK  # 0 = Sunday .. 6 = Saturday
    return 7 if civil == 0 else civil
