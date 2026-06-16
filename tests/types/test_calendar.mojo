# Calendar utilities: ISO week date (differential vs Python `date.isocalendar()`)
# and Western Easter (KAT vs published dates).

from chrono.calendar import iso_week_date, easter, IsoWeekDate
from chrono.date import Date


def _iso(
    year: Int,
    month: Int,
    day: Int,
    iso_year: Int,
    iso_week: Int,
    iso_weekday: Int,
) raises -> Int:
    var got = iso_week_date(Date(year, month, day))
    if got != IsoWeekDate(iso_year, iso_week, iso_weekday):
        print(
            "FAIL iso",
            year,
            month,
            day,
            "got",
            got.iso_year,
            got.iso_week,
            got.iso_weekday,
        )
        return 1
    return 0


def _easter(year: Int, month: Int, day: Int) raises -> Int:
    var got = easter(year)
    if got != Date(year, month, day):
        print("FAIL easter", year, "got", got.month().number(), got.day())
        return 1
    return 0


def run() raises -> Int:
    var f = 0

    # --- ISO week date (differential vs Python date.isocalendar()) ---
    f += _iso(2026, 6, 15, 2026, 25, 1)
    f += _iso(2026, 1, 1, 2026, 1, 4)
    f += _iso(2021, 1, 1, 2020, 53, 5)  # belongs to previous ISO year
    f += _iso(2020, 12, 31, 2020, 53, 4)
    f += _iso(2015, 12, 31, 2015, 53, 4)  # 53-week year
    f += _iso(2016, 1, 1, 2015, 53, 5)
    f += _iso(2026, 12, 31, 2026, 53, 4)
    f += _iso(2024, 2, 29, 2024, 9, 4)

    # --- Western Easter (KAT vs published dates) ---
    f += _easter(2024, 3, 31)
    f += _easter(2025, 4, 20)
    f += _easter(2026, 4, 5)
    f += _easter(2027, 3, 28)
    f += _easter(2000, 4, 23)
    f += _easter(1961, 4, 2)
    # Algorithm boundaries: the documented earliest (March 22) and latest
    # (April 25) Easter dates within the Gregorian table — these exercise the
    # `m` / `l` wrap on the Anonymous-Gregorian formula.
    f += _easter(1818, 3, 22)  # earliest in the table
    f += _easter(1943, 4, 25)  # latest in the table
    # The Gauss-correction boundary years: raw Gauss is off by a week here,
    # the Anonymous-Gregorian (Meeus/Jones/Butcher) correction gets them right.
    # A regression to raw Gauss would shift each by 7 days.
    f += _easter(1954, 4, 18)
    f += _easter(2049, 4, 18)
    f += _easter(1981, 4, 19)

    # The Anonymous-Gregorian algorithm is undefined before the 1582 calendar
    # reform; chrono raises rather than returning a silently anachronistic
    # date (Julian Easter belongs to the Orthodox-calendar code path, which
    # this library does not provide).
    var raised = False
    try:
        _ = easter(1582)
    except:
        raised = True
    if not raised:
        print("FAIL easter accepted pre-reform year 1582")
        f += 1

    if f == 0:
        print("test_calendar: PASS")
    return f
