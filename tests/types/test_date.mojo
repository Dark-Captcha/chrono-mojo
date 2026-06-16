# Date: the civil seam (weekday + day-of-year differential vs Python `datetime`),
# field round-trip, epoch-day conversion, day arithmetic, comparison, leap-year,
# and validation (out-of-range fields raise).

from chrono.date import Date
from chrono.enums import Weekday, Month


def _check(year: Int, month: Int, day: Int, iso: Int, yday: Int) raises -> Int:
    var f = 0
    var d = Date(year, month, day)
    if d.weekday().iso_number() != iso:
        print("FAIL weekday", year, month, day, "got", d.weekday().iso_number())
        f += 1
    if d.day_of_year() != yday:
        print("FAIL day_of_year", year, month, day, "got", d.day_of_year())
        f += 1
    if d.year() != year or d.month().number() != month or d.day() != day:
        print("FAIL field round-trip", year, month, day)
        f += 1
    return f


def run() raises -> Int:
    var f = 0

    # --- differential vs Python datetime (isoweekday, day-of-year) ---
    f += _check(2026, 6, 15, 1, 166)
    f += _check(1970, 1, 1, 4, 1)
    f += _check(2000, 1, 1, 6, 1)
    f += _check(2024, 12, 31, 2, 366)
    f += _check(2024, 2, 29, 4, 60)
    f += _check(1999, 12, 31, 5, 365)

    # --- epoch-day conversion ---
    var epoch = Date.from_days_since_epoch(0)
    if epoch.year() != 1970 or epoch.month().number() != 1 or epoch.day() != 1:
        print("FAIL from_days_since_epoch(0)")
        f += 1
    if Date(2026, 6, 15).days_since_epoch() != 20619:
        print("FAIL days_since_epoch")
        f += 1

    # --- day arithmetic ---
    var jul5 = Date(2026, 6, 15).plus_days(20)  # Jun 15 + 20 = Jul 5
    if jul5.month().number() != 7 or jul5.day() != 5:
        print("FAIL plus_days")
        f += 1
    if (Date(2026, 6, 15) - Date(2026, 6, 10)) != 5:
        print("FAIL date - date")
        f += 1
    if Date(2026, 1, 1).minus_days(1).year() != 2025:
        print("FAIL minus_days across year")
        f += 1

    # --- comparison + leap year ---
    if not (Date(2025, 1, 1) < Date(2026, 1, 1)):
        print("FAIL cmp <")
        f += 1
    if not (Date(2026, 6, 15) == Date(2026, 6, 15)):
        print("FAIL cmp ==")
        f += 1
    if not Date(2024, 1, 1).is_leap_year():
        print("FAIL leap 2024")
        f += 1
    if Date(2023, 1, 1).is_leap_year():
        print("FAIL leap 2023")
        f += 1

    # --- validation: out-of-range fields raise ---
    var raised = False
    try:
        _ = Date(2026, 13, 1)
    except:
        raised = True
    if not raised:
        print("FAIL accepted month 13")
        f += 1
    raised = False
    try:
        _ = Date(2026, 2, 30)
    except:
        raised = True
    if not raised:
        print("FAIL accepted Feb 30")
        f += 1

    if f == 0:
        print("test_date: PASS")
    return f
