# Calendar systems — a `Calendar` trait and three conforming calendars, each a pure
# conversion between its own (year, month, day) and the epoch-day (days since the Unix
# epoch, 1970-01-01). The epoch-day is the shared pivot: to convert a date between
# calendars, go through it (e.g. JulianCalendar.date_from_days_since_epoch(
# GregorianCalendar.days_since_epoch(2026, 6, 15))).
#
#   GregorianCalendar — proleptic Gregorian (wraps _core/civil).
#   JulianCalendar    — proleptic Julian (Richards' algorithm via the Julian Day Number).
#   IslamicCalendar   — the arithmetic Islamic calendar in the Reingold-Dershowitz
#                       "Type II / civil arithmetic" variant: 30-year leap cycle with
#                       leap years at positions {2,5,7,10,13,16,18,21,24,26,29};
#                       epoch JDN 1948440 = Julian 622-07-16. This is the deterministic
#                       tabular calendar, NOT the observational Hijri (which can differ
#                       by a day from moon sighting). NOTE: the Kuwaiti/Microsoft Hijri
#                       variant has leap position 15 instead of 16; chrono follows the
#                       civil-arithmetic convention, which matches the per-year leap
#                       distribution used by `Calendrical Calculations` (Reingold-
#                       Dershowitz, 3rd ed., ch. 7).
#
# Facets: tier T1 (breadth) | safety sound | quantum n/a.
# Honesty: Gregorian wraps the Python-verified core. Julian + Islamic are from spec
# (Richards / Reingold-Dershowitz tabular); no Python oracle is installed, so they are
# KAT-verified — including a cross-check that anchors the Islamic epoch to the verified
# Julian converter (Islamic 1-01-01 == Julian 622-07-16) — plus round-trip properties.

from chrono._core.civil import (
    days_since_epoch_from_date,
    date_from_days_since_epoch,
    YearMonthDay,
)

comptime _JDN_AT_EPOCH = 2440588  # Julian Day Number of 1970-01-01
comptime _ISLAMIC_EPOCH_JDN = 1948440  # JDN of Islamic 1 Muharram 1 AH (tabular civil)


trait Calendar:
    """A calendar system: a bijection between its civil fields and the epoch-day."""

    @staticmethod
    def days_since_epoch(year: Int, month: Int, day: Int) raises -> Int:
        ...

    @staticmethod
    def date_from_days_since_epoch(epoch_day: Int) -> YearMonthDay:
        ...


struct GregorianCalendar(Calendar):
    @staticmethod
    def days_since_epoch(year: Int, month: Int, day: Int) raises -> Int:
        return days_since_epoch_from_date(year, month, day)

    @staticmethod
    def date_from_days_since_epoch(epoch_day: Int) -> YearMonthDay:
        return date_from_days_since_epoch(epoch_day)


@always_inline
def _check_julian_fields(year: Int, month: Int, day: Int) raises:
    """Validate (year, month, day) for the proleptic Julian calendar. The
    Julian month structure matches Gregorian (Jan=31, Feb=28/29, ...) with the
    Julian leap rule `year % 4 == 0` for all years; February has 29 days iff
    `(year % 4) == 0` (including negative years under floor `%`)."""
    if month < 1 or month > 12:
        raise Error(
            "chrono.JulianCalendar: month out of range (1..12), got "
            + String(month)
        )
    var length: Int
    if month == 2:
        length = 29 if year % 4 == 0 else 28
    elif month == 4 or month == 6 or month == 9 or month == 11:
        length = 30
    else:
        length = 31
    if day < 1 or day > length:
        raise Error(
            "chrono.JulianCalendar: day out of range for "
            + String(year)
            + "-"
            + String(month)
            + " (1.."
            + String(length)
            + "), got "
            + String(day)
        )


struct JulianCalendar(Calendar):
    @staticmethod
    def days_since_epoch(year: Int, month: Int, day: Int) raises -> Int:
        _check_julian_fields(year, month, day)
        var a = (14 - month) // 12
        var y = year + 4800 - a
        var m = month + 12 * a - 3
        var jdn = day + (153 * m + 2) // 5 + 365 * y + y // 4 - 32083
        return jdn - _JDN_AT_EPOCH

    @staticmethod
    def date_from_days_since_epoch(epoch_day: Int) -> YearMonthDay:
        var jdn = epoch_day + _JDN_AT_EPOCH
        var c = jdn + 32082
        var d = (4 * c + 3) // 1461
        var e = c - (1461 * d) // 4
        var m = (5 * e + 2) // 153
        var day = e - (153 * m + 2) // 5 + 1
        var month = m + 3 - 12 * (m // 10)
        var year = d - 4800 + m // 10
        return YearMonthDay(year, month, day)


@always_inline
def _islamic_to_jdn(year: Int, month: Int, day: Int) -> Int:
    """JDN of a tabular Islamic date (months alternate 30/29, leap years add a day to
    the 12th month on a fixed 30-year cycle)."""
    return (
        day
        + (59 * (month - 1) + 1)
        // 2  # = ceil(29.5 * (month - 1)), days before month
        + (year - 1) * 354
        + (3 + 11 * year) // 30  # leap days elapsed in the cycle
        + _ISLAMIC_EPOCH_JDN
        - 1
    )


@always_inline
def _islamic_month_length(year: Int, month: Int) -> Int:
    """Tabular Islamic month length: odd months 30, even months 29, with the
    12th month getting a 30th day on leap years.

    `_islamic_to_jdn` adds `(3 + 11*y) // 30` as the count of leap years
    STRICTLY BEFORE year y. So year y is a leap year iff
    `count_before(y+1) - count_before(y) == 1` — using `(y-1)` instead would
    mis-flag year 2 (the first Type II leap) and shift every cycle by one."""
    if month == 12:
        var after = (3 + 11 * (year + 1)) // 30
        var before = (3 + 11 * year) // 30
        return 30 if after - before == 1 else 29
    return 30 if month % 2 == 1 else 29


@always_inline
def _check_islamic_fields(year: Int, month: Int, day: Int) raises:
    """Validate (year, month, day) against the tabular month lengths."""
    if month < 1 or month > 12:
        raise Error(
            "chrono.IslamicCalendar: month out of range (1..12), got "
            + String(month)
        )
    var length = _islamic_month_length(year, month)
    if day < 1 or day > length:
        raise Error(
            "chrono.IslamicCalendar: day out of range for "
            + String(year)
            + "-"
            + String(month)
            + " (1.."
            + String(length)
            + "), got "
            + String(day)
        )


struct IslamicCalendar(Calendar):
    @staticmethod
    def days_since_epoch(year: Int, month: Int, day: Int) raises -> Int:
        _check_islamic_fields(year, month, day)
        return _islamic_to_jdn(year, month, day) - _JDN_AT_EPOCH

    @staticmethod
    def date_from_days_since_epoch(epoch_day: Int) -> YearMonthDay:
        var jdn = epoch_day + _JDN_AT_EPOCH
        var year = (30 * (jdn - _ISLAMIC_EPOCH_JDN) + 10646) // 10631
        if jdn < _islamic_to_jdn(
            year, 1, 1
        ):  # guard the cycle-boundary estimate
            year -= 1
        var month = 1
        while month < 12 and _islamic_to_jdn(year, month + 1, 1) <= jdn:
            month += 1
        var day = jdn - _islamic_to_jdn(year, month, 1) + 1
        return YearMonthDay(year, month, day)
