# Calendar utilities over Date: the ISO 8601 week date and Western (Gregorian)
# Easter. Independent functions in the util layer — they depend on Date, not the
# other way round.
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: ISO week from spec, differential vs Python `date.isocalendar()`; Easter
# is the Anonymous Gregorian algorithm (Meeus/Jones/Butcher), KAT vs published dates.

from chrono.date import Date
from chrono._core.units import DAYS_PER_WEEK


struct IsoWeekDate(Equatable, TrivialRegisterPassable):
    """An ISO 8601 week date: the week-numbering year, the week (1..53), and the
    weekday (1 = Monday .. 7 = Sunday). Matches Python `date.isocalendar()`."""

    var iso_year: Int
    var iso_week: Int
    var iso_weekday: Int

    @always_inline
    def __init__(out self, iso_year: Int, iso_week: Int, iso_weekday: Int):
        self.iso_year = iso_year
        self.iso_week = iso_week
        self.iso_weekday = iso_weekday

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return (
            self.iso_year == other.iso_year
            and self.iso_week == other.iso_week
            and self.iso_weekday == other.iso_weekday
        )

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)


@always_inline
def _weekday_of_jan1_class(year: Int) -> Int:
    """Doomsday-style class of a year, used to decide 52 vs 53 ISO weeks."""
    return (year + year // 4 - year // 100 + year // 400) % DAYS_PER_WEEK


@always_inline
def _weeks_in_iso_year(year: Int) -> Int:
    """An ISO year has 53 weeks iff it starts on Thursday, or it is a leap year
    starting on Wednesday."""
    if (
        _weekday_of_jan1_class(year) == 4
        or _weekday_of_jan1_class(year - 1) == 3
    ):
        return 53
    return 52


def iso_week_date(date: Date) -> IsoWeekDate:
    """The ISO 8601 week date of `date` (weeks start Monday; week 1 contains the
    year's first Thursday). Days in early January / late December may belong to the
    adjacent ISO year."""
    var ordinal = date.day_of_year()
    var weekday = date.weekday().iso_number()  # 1..7
    var week = (ordinal - weekday + 10) // DAYS_PER_WEEK
    var year = date.year()
    if week < 1:
        return IsoWeekDate(year - 1, _weeks_in_iso_year(year - 1), weekday)
    if week > _weeks_in_iso_year(year):
        return IsoWeekDate(year + 1, 1, weekday)
    return IsoWeekDate(year, week, weekday)


def easter(year: Int) raises -> Date:
    """Western (Gregorian) Easter Sunday for `year`, via the Anonymous Gregorian
    algorithm (Meeus/Jones/Butcher). Single-letter names follow the standard
    formulation; each is an opaque intermediate.

    The Gregorian calendar reform took effect 1582-10-15, so the algorithm has
    no defined meaning before 1583 — Easter prior to the reform was computed
    on the Julian calendar (use `JulianCalendar` + the Orthodox-Easter
    algorithm, which is not provided here). Raise on `year < 1583` rather than
    return a silently anachronistic date."""
    if year < 1583:
        raise Error(
            "chrono.easter: Gregorian Easter is undefined before the 1583"
            " calendar reform, got year=" + String(year)
        )
    var a = year % 19
    var b = year // 100
    var c = year % 100
    var d = b // 4
    var e = b % 4
    var f = (b + 8) // 25
    var g = (b - f + 1) // 3
    var h = (19 * a + b - d - g + 15) % 30
    var i = c // 4
    var k = c % 4
    var l = (32 + 2 * e + 2 * i - h - k) % DAYS_PER_WEEK
    var m = (a + 11 * h + 22 * l) // 451
    var month = (h + l - 7 * m + 114) // 31
    var day = (h + l - 7 * m + 114) % 31 + 1
    return Date(year, month, day)
