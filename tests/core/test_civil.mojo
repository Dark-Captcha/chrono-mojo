# Three-layer verification of the civil-date core:
#   KAT/differential — vectors generated from Python `datetime` (year >= 1),
#     checking forward (date -> day), inverse (day -> date), and weekday.
#   property — day -> civil -> day round-trip, including proleptic year < 1 where
#     Python's datetime cannot serve as an oracle.
#   leap/length — the 100/400 leap exceptions and month lengths.

from chrono._core.civil import (
    days_since_epoch_from_date,
    date_from_days_since_epoch,
)
from chrono._core.civil import (
    weekday_from_days_since_epoch,
    is_leap_year,
    days_in_month,
)
from chrono._core.civil import YearMonthDay


def _check(
    year: Int, month: Int, day: Int, epoch_day: Int, weekday: Int
) raises -> Int:
    """One differential vector: forward, inverse, and weekday must all agree."""
    var f = 0
    var forward = days_since_epoch_from_date(year, month, day)
    if forward != epoch_day:
        print(
            "FAIL forward", year, month, day, "got", forward, "want", epoch_day
        )
        f += 1
    if date_from_days_since_epoch(epoch_day) != YearMonthDay(year, month, day):
        print("FAIL inverse epoch_day", epoch_day)
        f += 1
    var weekday_got = weekday_from_days_since_epoch(epoch_day)
    if weekday_got != weekday:
        print("FAIL weekday", epoch_day, "got", weekday_got, "want", weekday)
        f += 1
    return f


def _roundtrip(days: Int) raises -> Int:
    """Property: day -> civil -> day is the identity (covers proleptic year < 1)."""
    var ymd = date_from_days_since_epoch(days)
    if days_since_epoch_from_date(ymd.year, ymd.month, ymd.day) != days:
        print("FAIL roundtrip", days)
        return 1
    return 0


def run() raises -> Int:
    var f = 0

    # --- Differential vs Python datetime: (year, month, day, epoch_day, weekday) ---
    # weekday is 0=Sunday..6=Saturday (date.isoweekday() % 7).
    f += _check(1970, 1, 1, 0, 4)
    f += _check(1969, 12, 31, -1, 3)
    f += _check(2000, 2, 29, 11016, 2)
    f += _check(2000, 3, 1, 11017, 3)
    f += _check(1900, 2, 28, -25509, 3)
    f += _check(1900, 3, 1, -25508, 4)
    f += _check(2024, 2, 29, 19782, 4)
    f += _check(2026, 6, 15, 20619, 1)
    f += _check(1, 1, 1, -719162, 1)
    f += _check(9999, 12, 31, 2932896, 5)
    f += _check(2010, 1, 1, 14610, 5)
    f += _check(2016, 7, 8, 16990, 5)
    f += _check(2025, 12, 31, 20453, 3)
    f += _check(1700, 3, 1, -98556, 1)
    f += _check(1582, 10, 15, -141427, 5)

    # --- Round-trip property, including proleptic (year < 1) ---
    f += _roundtrip(-2000000)
    f += _roundtrip(-1000000)
    f += _roundtrip(-719163)
    f += _roundtrip(-100000)
    f += _roundtrip(0)
    f += _roundtrip(100000)
    f += _roundtrip(2932896)
    f += _roundtrip(5000000)

    # --- is_leap_year: the 100/400 exceptions ---
    if not is_leap_year(2000):
        print("FAIL leap 2000")
        f += 1
    if is_leap_year(1900):
        print("FAIL leap 1900")
        f += 1
    if not is_leap_year(2024):
        print("FAIL leap 2024")
        f += 1
    if is_leap_year(2023):
        print("FAIL leap 2023")
        f += 1
    # Proleptic leap year — floor `%` keeps the 100/400 rule correct for year 0
    # and the BCE range. Year 0 is divisible by 400, so a leap year (matches
    # Python `calendar.isleap(0)`); -4 is divisible by 4 but not 100.
    if not is_leap_year(0):
        print("FAIL leap year 0 (proleptic 100/400)")
        f += 1
    if not is_leap_year(-4):
        print("FAIL leap year -4 (proleptic)")
        f += 1
    if is_leap_year(-1):
        print("FAIL leap year -1 (proleptic, not divisible by 4)")
        f += 1

    # --- days_in_month ---
    if days_in_month(2000, 2) != 29:
        print("FAIL dim Feb-2000")
        f += 1
    if days_in_month(1900, 2) != 28:
        print("FAIL dim Feb-1900")
        f += 1
    if days_in_month(2024, 4) != 30:
        print("FAIL dim Apr")
        f += 1
    if days_in_month(2025, 1) != 31:
        print("FAIL dim Jan")
        f += 1
    if days_in_month(2025, 12) != 31:
        print("FAIL dim Dec")
        f += 1

    if f == 0:
        print("test_civil: PASS")
    return f
