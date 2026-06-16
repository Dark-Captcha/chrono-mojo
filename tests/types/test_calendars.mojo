# Calendar systems: Julian + Islamic conversions (KAT, since no Python oracle is
# installed), the Gregorian wrapper, cross-calendar conversion via the epoch-day,
# round-trip properties, and trait-based polymorphism. The Islamic epoch is
# cross-checked against the (separately KAT-verified) Julian converter.

from chrono.calendars import (
    Calendar,
    GregorianCalendar,
    JulianCalendar,
    IslamicCalendar,
)
from chrono._core.civil import YearMonthDay


def _first_epoch_day[C: Calendar]() raises -> Int:
    # exercises trait dispatch: each calendar's own (1,1,1)
    return C.days_since_epoch(1, 1, 1)


def run() raises -> Int:
    var f = 0

    # --- Julian (KAT) ---
    if JulianCalendar.date_from_days_since_epoch(0) != YearMonthDay(
        1969, 12, 19
    ):
        print("FAIL Julian epoch0")
        f += 1
    if JulianCalendar.days_since_epoch(1969, 12, 19) != 0:
        print("FAIL Julian to_epoch round-trip")
        f += 1
    if JulianCalendar.date_from_days_since_epoch(10957) != YearMonthDay(
        1999, 12, 19
    ):
        print("FAIL Julian 2000-01-01 -> 1999-12-19")
        f += 1
    if JulianCalendar.date_from_days_since_epoch(-141427) != YearMonthDay(
        1582, 10, 5
    ):
        print("FAIL Julian Gregorian-reform date")
        f += 1

    # --- Islamic (KAT, tabular civil) ---
    if IslamicCalendar.days_since_epoch(1, 1, 1) != -492148:
        print("FAIL Islamic epoch")
        f += 1
    # cross-check: the Islamic epoch IS Julian 622-07-16 (anchors to the Julian converter)
    if IslamicCalendar.days_since_epoch(
        1, 1, 1
    ) != JulianCalendar.days_since_epoch(622, 7, 16):
        print("FAIL Islamic epoch != Julian 622-07-16")
        f += 1
    if IslamicCalendar.days_since_epoch(1447, 1, 1) != 20266:
        print("FAIL Islamic 1447-01-01")
        f += 1
    if IslamicCalendar.days_since_epoch(1446, 9, 1) != 20148:
        print("FAIL Islamic 1446-09-01 (Ramadan)")
        f += 1
    if IslamicCalendar.days_since_epoch(1444, 1, 1) != 19203:
        print("FAIL Islamic 1444-01-01")
        f += 1
    if IslamicCalendar.date_from_days_since_epoch(20266) != YearMonthDay(
        1447, 1, 1
    ):
        print("FAIL Islamic from_epoch 20266")
        f += 1

    # --- Gregorian wrapper + cross-calendar conversion via epoch-day ---
    var pivot = GregorianCalendar.days_since_epoch(2026, 6, 15)
    if pivot != 20619:
        print("FAIL Gregorian wrapper")
        f += 1
    # 2026-06-15 Gregorian is 13 days ahead of Julian -> Julian 2026-06-02
    if JulianCalendar.date_from_days_since_epoch(pivot) != YearMonthDay(
        2026, 6, 2
    ):
        print("FAIL cross-calendar Gregorian->Julian")
        f += 1

    # --- round-trip properties over a wide range ---
    var day = -500000
    while day <= 50000:
        var jy = JulianCalendar.date_from_days_since_epoch(day)
        if JulianCalendar.days_since_epoch(jy.year, jy.month, jy.day) != day:
            print("FAIL Julian round-trip", day)
            f += 1
            break
        var iy = IslamicCalendar.date_from_days_since_epoch(day)
        if IslamicCalendar.days_since_epoch(iy.year, iy.month, iy.day) != day:
            print("FAIL Islamic round-trip", day)
            f += 1
            break
        day += 131

    # --- trait dispatch ---
    if _first_epoch_day[IslamicCalendar]() != -492148:
        print("FAIL trait dispatch Islamic")
        f += 1
    if _first_epoch_day[
        GregorianCalendar
    ]() != GregorianCalendar.days_since_epoch(1, 1, 1):
        print("FAIL trait dispatch Gregorian")
        f += 1

    # --- field validation on direct calendar APIs ---
    # JulianCalendar / IslamicCalendar previously trusted (month, day) without
    # validation, producing a silently shifted JDN for nonsense inputs like
    # `(month=13, day=1)`. Both must raise now.
    var raised = False
    try:
        _ = JulianCalendar.days_since_epoch(2026, 13, 1)
    except:
        raised = True
    if not raised:
        print("FAIL JulianCalendar accepted month 13")
        f += 1
    raised = False
    try:
        _ = JulianCalendar.days_since_epoch(2027, 2, 29)  # Julian 2027 not leap
    except:
        raised = True
    if not raised:
        print("FAIL JulianCalendar accepted Feb 29 in a non-leap year")
        f += 1
    raised = False
    try:
        _ = IslamicCalendar.days_since_epoch(1, 13, 1)
    except:
        raised = True
    if not raised:
        print("FAIL IslamicCalendar accepted month 13")
        f += 1
    raised = False
    try:
        # Year 1446 is at cycle position 6 — NOT a Type II leap year; month 12
        # has 29 days. (Year 1447 is position 7, which IS a leap year, so an
        # off-by-one in the leap rule would silently accept 1447-12-30 too.)
        _ = IslamicCalendar.days_since_epoch(1446, 12, 30)
    except:
        raised = True
    if not raised:
        print(
            "FAIL IslamicCalendar accepted day 30 of month 12 in non-leap year"
        )
        f += 1
    # Sanity: known leap years (Type II positions 2, 5, 7) DO allow day 30 in
    # month 12, so the check above isn't over-rejecting.
    _ = IslamicCalendar.days_since_epoch(2, 12, 30)
    _ = IslamicCalendar.days_since_epoch(1447, 12, 30)

    if f == 0:
        print("test_calendars: PASS")
    return f
