# HttpDate (RFC 7231 IMF-fixdate) + Rfc2822 (email) format/parse — pinned KAT,
# round-trip, and malformed rejection. Expected strings were captured from
# Python `email.utils` and frozen here; regenerate manually if the oracle's
# rendering changes.

from chrono.format.rfc2822 import HttpDate, Rfc2822
from chrono.datetime import DateTime
from chrono.offset import Offset
from chrono.offset_datetime import OffsetDateTime


def run() raises -> Int:
    var f = 0
    var moment = DateTime(2026, 6, 15, 14, 30, 45)  # a Monday

    # --- HTTP-date (always GMT) ---
    if HttpDate.format(moment) != "Mon, 15 Jun 2026 14:30:45 GMT":
        print("FAIL HttpDate.format")
        f += 1
    if HttpDate.parse("Mon, 15 Jun 2026 14:30:45 GMT") != moment:
        print("FAIL HttpDate.parse")
        f += 1
    if HttpDate.parse(HttpDate.format(moment)) != moment:
        print("FAIL HttpDate round-trip")
        f += 1

    # --- RFC 2822 (numeric offset) ---
    if (
        Rfc2822.format(OffsetDateTime(moment, Offset(7)))
        != "Mon, 15 Jun 2026 14:30:45 +0700"
    ):
        print("FAIL Rfc2822.format +0700")
        f += 1
    if (
        Rfc2822.format(OffsetDateTime(moment, Offset.UTC))
        != "Mon, 15 Jun 2026 14:30:45 +0000"
    ):
        print("FAIL Rfc2822.format +0000")
        f += 1
    if (
        Rfc2822.format(
            OffsetDateTime(DateTime(2026, 1, 5, 9, 5, 3), Offset(-5, -30))
        )
        != "Mon, 05 Jan 2026 09:05:03 -0530"
    ):
        print("FAIL Rfc2822.format -0530")
        f += 1

    var p = Rfc2822.parse("Mon, 15 Jun 2026 14:30:45 +0700")
    if p.datetime() != moment or p.offset().total_seconds() != 25200:
        print("FAIL Rfc2822.parse")
        f += 1

    # --- malformed rejection ---
    var raised = False
    try:
        _ = HttpDate.parse(
            "Mon, 15 Jun 2026 14:30:45 +0700"
        )  # not GMT / wrong length
    except:
        raised = True
    if not raised:
        print("FAIL HttpDate accepted non-GMT")
        f += 1
    raised = False
    try:
        _ = Rfc2822.parse(
            "Mon, 15 Jun 2026 14:30:45 GMT"
        )  # named zone, not numeric
    except:
        raised = True
    if not raised:
        print("FAIL Rfc2822 accepted named zone")
        f += 1

    # Weekday label must match the resolved date (RFC 5322 §3.3); silently
    # accepting "Tue" for a Monday was the audit defect.
    raised = False
    try:
        _ = HttpDate.parse("Tue, 15 Jun 2026 14:30:45 GMT")
    except:
        raised = True
    if not raised:
        print("FAIL HttpDate accepted wrong weekday label")
        f += 1
    raised = False
    try:
        _ = Rfc2822.parse("Fri, 15 Jun 2026 14:30:45 +0000")
    except:
        raised = True
    if not raised:
        print("FAIL Rfc2822 accepted wrong weekday label")
        f += 1

    # Leap-second at 23:59 UTC folds, but a non-UTC offset disqualifies the
    # window (RFC 3339 §5.6 — chrono uses the same gate for RFC 2822 since the
    # leap second is a UTC-relative event).
    raised = False
    try:
        _ = Rfc2822.parse("Sat, 31 Dec 2016 23:59:60 +0700")
    except:
        raised = True
    if not raised:
        print("FAIL Rfc2822 accepted ':60' with non-UTC offset")
        f += 1

    # RFC 5322 §3.3 numeric zone is `[+-]HHMM` where each half is its own
    # 2-digit range. Per-component validation was missing — `+0575` parsed
    # silently because the total (5h75m) stayed under the ±18h cap.
    raised = False
    try:
        _ = Rfc2822.parse("Mon, 15 Jun 2026 14:30:45 +0575")
    except:
        raised = True
    if not raised:
        print("FAIL Rfc2822 accepted offset minute >= 60")
        f += 1
    raised = False
    try:
        _ = Rfc2822.parse("Mon, 15 Jun 2026 14:30:45 +2400")
    except:
        raised = True
    if not raised:
        print("FAIL Rfc2822 accepted offset hour >= 24")
        f += 1

    if f == 0:
        print("test_rfc2822: PASS")
    return f
