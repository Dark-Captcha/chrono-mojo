# Span: calendar add/subtract on Date with end-of-month clamping + rollover
# (differential vs a Python reference), Span arithmetic, and DateTime.plus_span
# keeping the time of day.

from chrono.span import Span
from chrono.date import Date
from chrono.datetime import DateTime


def _check(
    year: Int,
    month: Int,
    day: Int,
    add_years: Int,
    add_months: Int,
    add_days: Int,
    expect_year: Int,
    expect_month: Int,
    expect_day: Int,
) raises -> Int:
    var got = Date(year, month, day).plus_span(
        Span(add_years, add_months, add_days)
    )
    if got != Date(expect_year, expect_month, expect_day):
        print(
            "FAIL span",
            year,
            month,
            day,
            "got",
            got.year(),
            got.month().number(),
            got.day(),
        )
        return 1
    return 0


def run() raises -> Int:
    var f = 0

    # --- calendar add with clamp / rollover (differential vs Python reference) ---
    f += _check(2026, 1, 31, 0, 1, 0, 2026, 2, 28)  # clamp to Feb 28
    f += _check(2024, 2, 29, 1, 0, 0, 2025, 2, 28)  # leap -> non-leap clamp
    f += _check(2026, 12, 15, 0, 2, 0, 2027, 2, 15)  # year rollover
    f += _check(2020, 2, 29, 4, 0, 0, 2024, 2, 29)  # leap -> leap, no clamp
    f += _check(2026, 3, 31, 0, -1, 0, 2026, 2, 28)  # negative month + clamp
    f += _check(2026, 6, 15, 1, 1, 1, 2027, 7, 16)  # combined
    f += _check(2026, 1, 1, 0, -1, 0, 2025, 12, 1)  # negative across year
    f += _check(2000, 1, 31, 0, 13, 0, 2001, 2, 28)  # >12 months

    # --- Span arithmetic + factories ---
    if Span(1, 2, 3) + Span(0, 1, 0) != Span(1, 3, 3):
        print("FAIL Span +")
        f += 1
    if -Span(1, 2, 3) != Span(-1, -2, -3):
        print("FAIL Span neg")
        f += 1
    if Span.from_weeks(2).days() != 14:
        print("FAIL Span.from_weeks")
        f += 1
    if Span(years=5).years() != 5 or Span(months=3).months() != 3:
        print("FAIL Span keyword ctor")
        f += 1

    # --- minus_span ---
    if Date(2026, 2, 28).minus_span(Span(months=1)) != Date(2026, 1, 28):
        print("FAIL minus_span")
        f += 1

    # --- DateTime.plus_span keeps the time of day ---
    var shifted = DateTime(2026, 1, 31, 14, 30, 0).plus_span(Span(months=1))
    if (
        shifted.year() != 2026
        or shifted.month().number() != 2
        or shifted.day() != 28
        or shifted.hour() != 14
        or shifted.minute() != 30
    ):
        print("FAIL DateTime.plus_span")
        f += 1

    # --- adversarial field overflow ---
    # Span fields are bounded to Int32 (~178M years either way). A pathological
    # `Span(years=Int.MAX/12)` could otherwise overflow the downstream
    # `year * 12 + month + delta` fold in `_core/civil`. Each axis must reject.
    var raised = False
    try:
        _ = Span(years=3_000_000_000)
    except:
        raised = True
    if not raised:
        print("FAIL Span accepted out-of-Int32 years")
        f += 1
    raised = False
    try:
        _ = Span(months=-3_000_000_000)
    except:
        raised = True
    if not raised:
        print("FAIL Span accepted out-of-Int32 months")
        f += 1
    raised = False
    try:
        _ = Span(days=3_000_000_000)
    except:
        raised = True
    if not raised:
        print("FAIL Span accepted out-of-Int32 days")
        f += 1

    if f == 0:
        print("test_span: PASS")
    return f
