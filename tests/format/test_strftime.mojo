# Strftime: the common directive subset, differential vs Python datetime.strftime
# (English/C locale), the 12-hour / AM-PM edge at midnight, unknown-directive
# rejection, AND the symmetric `parse` (strptime) round-trip.

from chrono.format.strftime import Strftime
from chrono.datetime import DateTime


def run() raises -> Int:
    var f = 0

    var moment = DateTime(2026, 6, 15, 14, 30, 45)
    if Strftime.format(moment, "%Y-%m-%d") != "2026-06-15":
        print("FAIL %Y-%m-%d")
        f += 1
    if Strftime.format(moment, "%H:%M:%S") != "14:30:45":
        print("FAIL %H:%M:%S")
        f += 1
    if Strftime.format(moment, "%A %d %B %Y") != "Monday 15 June 2026":
        print("FAIL names")
        f += 1
    if Strftime.format(moment, "%a %b %d") != "Mon Jun 15":
        print("FAIL abbrev names")
        f += 1
    if Strftime.format(moment, "%y/%m/%d") != "26/06/15":
        print("FAIL %y")
        f += 1
    if Strftime.format(moment, "%I:%M %p") != "02:30 PM":
        print("FAIL 12-hour PM")
        f += 1
    if Strftime.format(moment, "%j") != "166":
        print("FAIL %j")
        f += 1
    if Strftime.format(moment, "%d%% of %Y") != "15% of 2026":
        print("FAIL literal %% + text")
        f += 1

    # midnight -> 12 AM
    if Strftime.format(DateTime(2026, 1, 1, 0, 0, 0), "%I %p") != "12 AM":
        print("FAIL midnight 12 AM")
        f += 1

    # unknown directive raises (format)
    var raised = False
    try:
        _ = Strftime.format(moment, "%Q")
    except:
        raised = True
    if not raised:
        print("FAIL accepted unknown directive (format)")
        f += 1

    # --- parse (strptime) round-trip + edge cases ---

    if Strftime.parse("2026-06-15", "%Y-%m-%d") != DateTime(
        2026, 6, 15, 0, 0, 0
    ):
        print("FAIL parse %Y-%m-%d")
        f += 1

    if Strftime.parse("2026-06-15 14:30:45", "%Y-%m-%d %H:%M:%S") != DateTime(
        2026, 6, 15, 14, 30, 45
    ):
        print("FAIL parse full datetime")
        f += 1

    # %y pivot: 26 -> 2026, 99 -> 1999
    if Strftime.parse("26/06/15", "%y/%m/%d") != DateTime(2026, 6, 15, 0, 0, 0):
        print("FAIL parse %y pivot 26 -> 2026")
        f += 1
    if Strftime.parse("99/06/15", "%y/%m/%d") != DateTime(1999, 6, 15, 0, 0, 0):
        print("FAIL parse %y pivot 99 -> 1999")
        f += 1

    # %A %B (full names): the value of %A is verified to be a weekday but not
    # used (date determines weekday); %B sets the month.
    if Strftime.parse("Monday 15 June 2026", "%A %d %B %Y") != DateTime(
        2026, 6, 15, 0, 0, 0
    ):
        print("FAIL parse full weekday + month name")
        f += 1

    # %a %b (abbreviated names)
    if Strftime.parse("Mon Jun 15", "%a %b %d") != DateTime(
        1970, 6, 15, 0, 0, 0
    ):
        print("FAIL parse abbreviated names + epoch default year")
        f += 1

    # %I + %p — 12-hour clock combines with AM/PM
    if Strftime.parse("02:30 PM", "%I:%M %p") != DateTime(
        1970, 1, 1, 14, 30, 0
    ):
        print("FAIL parse 12-hour PM -> 14:30")
        f += 1
    if Strftime.parse("12 AM", "%I %p") != DateTime(1970, 1, 1, 0, 0, 0):
        print("FAIL parse 12 AM -> midnight")
        f += 1
    if Strftime.parse("12 PM", "%I %p") != DateTime(1970, 1, 1, 12, 0, 0):
        print("FAIL parse 12 PM -> noon")
        f += 1

    # literal % round-trip
    if Strftime.parse("15% of 2026", "%d%% of %Y") != DateTime(
        2026, 1, 15, 0, 0, 0
    ):
        print("FAIL parse literal %%")
        f += 1

    # full format/parse round-trip across every directive together
    var pattern = "%A %B %d %Y %H:%M:%S"
    var rendered = Strftime.format(moment, pattern)
    var roundtripped = Strftime.parse(rendered, pattern)
    if roundtripped != moment:
        print("FAIL format/parse round-trip on %A %B %d %Y %H:%M:%S")
        f += 1

    # parse must reject unknown directive
    raised = False
    try:
        _ = Strftime.parse("X", "%Q")
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted unknown directive")
        f += 1

    # parse must reject %j (day-of-year)
    raised = False
    try:
        _ = Strftime.parse("166", "%j")
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted unsupported %j")
        f += 1

    # parse must reject literal mismatch
    raised = False
    try:
        _ = Strftime.parse("2026/06/15", "%Y-%m-%d")  # wrong separator
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted wrong literal separator")
        f += 1

    # parse must reject trailing input
    raised = False
    try:
        _ = Strftime.parse("2026-06-15 extra", "%Y-%m-%d")
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted trailing input")
        f += 1

    # parse must reject bad month / weekday name
    raised = False
    try:
        _ = Strftime.parse("Smarch 15 2026", "%B %d %Y")
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted bad month name")
        f += 1

    # %I out of range raises
    raised = False
    try:
        _ = Strftime.parse("13 PM", "%I %p")
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted %I=13")
        f += 1

    # %y pivot endpoints: 00 -> 2000, 49 -> 2049, 50 -> 1950
    if Strftime.parse("00/06/15", "%y/%m/%d") != DateTime(2000, 6, 15, 0, 0, 0):
        print("FAIL parse %y pivot 00 -> 2000")
        f += 1
    if Strftime.parse("49/06/15", "%y/%m/%d") != DateTime(2049, 6, 15, 0, 0, 0):
        print("FAIL parse %y pivot 49 -> 2049")
        f += 1
    if Strftime.parse("50/06/15", "%y/%m/%d") != DateTime(1950, 6, 15, 0, 0, 0):
        print("FAIL parse %y pivot 50 -> 1950")
        f += 1

    # parsed weekday must match the resolved date (1970-01-01 was a Thursday, NOT
    # a Monday — silently accepting "Mon" against the default date is the bug
    # the audit caught).
    raised = False
    try:
        _ = Strftime.parse("Mon", "%a")
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted weekday disagreeing with default date")
        f += 1

    # full-name weekday: same check on the long form
    raised = False
    try:
        _ = Strftime.parse(
            "Tuesday 15 June 2026", "%A %d %B %Y"
        )  # 2026-06-15 is a Monday
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted full weekday name disagreeing with date")
        f += 1

    # %I without %p is ambiguous — silently mapping 12 to midnight AM was the
    # bug. The parser now requires %p.
    raised = False
    try:
        _ = Strftime.parse("12", "%I")
    except:
        raised = True
    if not raised:
        print("FAIL parse accepted %I without %p")
        f += 1

    # Negative year in format raises (pad would emit "0-44").
    raised = False
    try:
        _ = Strftime.format(DateTime(-44, 6, 15), "%Y")
    except:
        raised = True
    if not raised:
        print("FAIL format accepted negative year")
        f += 1

    # Year > 9999 in format raises (the %Y field is fixed-width 4 digits).
    raised = False
    try:
        _ = Strftime.format(DateTime(10000, 1, 1), "%Y")
    except:
        raised = True
    if not raised:
        print("FAIL format accepted year > 9999")
        f += 1

    if f == 0:
        print("test_strftime: PASS")
    return f
