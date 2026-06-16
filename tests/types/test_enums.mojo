# Weekday / Month enums: member numbering, names, equality.

from chrono.enums import Weekday, Month


def run() raises -> Int:
    var f = 0

    if Weekday.MONDAY.iso_number() != 1:
        print("FAIL Weekday.MONDAY")
        f += 1
    if Weekday.SUNDAY.iso_number() != 7:
        print("FAIL Weekday.SUNDAY")
        f += 1
    if String(Weekday.WEDNESDAY.name()) != "Wednesday":
        print("FAIL Weekday name")
        f += 1
    if not (Weekday.MONDAY == Weekday(1)):
        print("FAIL Weekday ==")
        f += 1
    if Weekday.MONDAY == Weekday.TUESDAY:
        print("FAIL Weekday != distinct")
        f += 1

    if Month.JANUARY.number() != 1:
        print("FAIL Month.JANUARY")
        f += 1
    if Month.DECEMBER.number() != 12:
        print("FAIL Month.DECEMBER")
        f += 1
    if String(Month.JUNE.name()) != "June":
        print("FAIL Month name")
        f += 1
    if not (Month.JUNE == Month(6)):
        print("FAIL Month ==")
        f += 1

    # Validating ctor rejects out-of-range — the audit found these silently
    # accepting garbage (`Weekday(99)`, `Month(13)`).
    var raised = False
    try:
        _ = Weekday(8)
    except:
        raised = True
    if not raised:
        print("FAIL Weekday accepted 8")
        f += 1
    raised = False
    try:
        _ = Weekday(0)
    except:
        raised = True
    if not raised:
        print("FAIL Weekday accepted 0")
        f += 1
    raised = False
    try:
        _ = Month(13)
    except:
        raised = True
    if not raised:
        print("FAIL Month accepted 13")
        f += 1
    raised = False
    try:
        _ = Month(0)
    except:
        raised = True
    if not raised:
        print("FAIL Month accepted 0")
        f += 1

    if f == 0:
        print("test_enums: PASS")
    return f
