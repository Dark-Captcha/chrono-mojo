# YearMonth + MonthDay: fields, month-length, day construction, month arithmetic
# with rollover, leap-day handling, comparison, and validation.

from chrono.partials import YearMonth, MonthDay
from chrono.date import Date


def run() raises -> Int:
    var f = 0

    # --- YearMonth ---
    var ym = YearMonth(2026, 6)
    if ym.year() != 2026 or ym.month().number() != 6:
        print("FAIL YearMonth fields")
        f += 1
    if ym.length_of_month() != 30:
        print("FAIL YearMonth length June")
        f += 1
    if YearMonth(2024, 2).length_of_month() != 29:
        print("FAIL YearMonth length Feb leap")
        f += 1
    if ym.first_day() != Date(2026, 6, 1) or ym.last_day() != Date(2026, 6, 30):
        print("FAIL YearMonth first/last day")
        f += 1
    if ym.at_day(15) != Date(2026, 6, 15):
        print("FAIL YearMonth at_day")
        f += 1
    if YearMonth(2026, 12).plus_months(1) != YearMonth(2027, 1):
        print("FAIL YearMonth plus_months rollover")
        f += 1
    if YearMonth(2026, 1).minus_months(1) != YearMonth(2025, 12):
        print("FAIL YearMonth minus_months")
        f += 1
    if not (YearMonth(2025, 12) < YearMonth(2026, 1)):
        print("FAIL YearMonth compare")
        f += 1
    var raised = False
    try:
        _ = YearMonth(2026, 13)
    except:
        raised = True
    if not raised:
        print("FAIL YearMonth accepted month 13")
        f += 1

    # --- MonthDay ---
    var md = MonthDay(2, 29)  # a valid leap-day month-day
    if md.month().number() != 2 or md.day() != 29:
        print("FAIL MonthDay fields")
        f += 1
    if not md.is_valid_in_year(2024) or md.is_valid_in_year(2025):
        print("FAIL MonthDay is_valid_in_year")
        f += 1
    if md.at_year(2024) != Date(2024, 2, 29):
        print("FAIL MonthDay at_year leap")
        f += 1
    raised = False
    try:
        _ = md.at_year(2025)  # Feb 29 invalid in a non-leap year
    except:
        raised = True
    if not raised:
        print("FAIL MonthDay at_year accepted Feb 29 non-leap")
        f += 1
    if not (MonthDay(1, 1) < MonthDay(12, 31)):
        print("FAIL MonthDay compare")
        f += 1
    raised = False
    try:
        _ = MonthDay(2, 30)  # never valid
    except:
        raised = True
    if not raised:
        print("FAIL MonthDay accepted Feb 30")
        f += 1

    if f == 0:
        print("test_partials: PASS")
    return f
