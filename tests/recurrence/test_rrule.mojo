# RecurrenceRule: occurrence expansion verified differential vs python-dateutil's
# rrule across the supported subset — DAILY/WEEKLY/MONTHLY/YEARLY, INTERVAL, COUNT,
# UNTIL, BYMONTH, BYMONTHDAY, and BYDAY with ordinals (incl. -1 = last). Expected
# instants (UTC epoch-seconds) are pinned KAT — they were captured from
# python-dateutil 2.9 at vector-generation time, then frozen here; regenerate
# manually when dateutil's behaviour changes.

from chrono.recurrence.rrule import RecurrenceRule
from chrono.datetime import DateTime


def _check(
    name: String,
    dtstart: DateTime,
    rule_text: String,
    expected: List[Int64],
) raises -> Int:
    var rule = RecurrenceRule.parse(rule_text)
    var got = rule.occurrences(dtstart)
    if len(got) != len(expected):
        print("FAIL", name, "count got", len(got), "want", len(expected))
        return 1
    for i in range(len(expected)):
        var instant = got[i].to_utc_instant().seconds_since_epoch()
        if instant != expected[i]:
            print("FAIL", name, "occ", i, "got", instant, "want", expected[i])
            return 1
    return 0


def run() raises -> Int:
    var f = 0

    var e1 = List[Int64]()
    e1.append(1767258000)
    e1.append(1767430800)
    e1.append(1767603600)
    e1.append(1767776400)
    e1.append(1767949200)
    f += _check(
        "DAILY int2 count5",
        DateTime(2026, 1, 1, 9, 0, 0),
        "FREQ=DAILY;INTERVAL=2;COUNT=5",
        e1,
    )

    var e2 = List[Int64]()
    e2.append(1767344400)
    e2.append(1767603600)
    e2.append(1767776400)
    e2.append(1767949200)
    e2.append(1768208400)
    e2.append(1768381200)
    f += _check(
        "WEEKLY MWF count6",
        DateTime(2026, 1, 1, 9, 0, 0),
        "FREQ=WEEKLY;BYDAY=MO,WE,FR;COUNT=6",
        e2,
    )

    var e3 = List[Int64]()
    e3.append(1768467600)
    e3.append(1771146000)
    e3.append(1773565200)
    e3.append(1776243600)
    f += _check(
        "MONTHLY 15th count4",
        DateTime(2026, 1, 1, 9, 0, 0),
        "FREQ=MONTHLY;BYMONTHDAY=15;COUNT=4",
        e3,
    )

    var e4 = List[Int64]()
    e4.append(1768294800)
    e4.append(1770714000)
    e4.append(1773133200)
    e4.append(1776157200)
    f += _check(
        "MONTHLY 2nd Tue count4",
        DateTime(2026, 1, 1, 9, 0, 0),
        "FREQ=MONTHLY;BYDAY=2TU;COUNT=4",
        e4,
    )

    var e5 = List[Int64]()
    e5.append(1769331600)
    e5.append(1771750800)
    e5.append(1774774800)
    e5.append(1777194000)
    f += _check(
        "MONTHLY last Sun count4",
        DateTime(2026, 1, 1, 9, 0, 0),
        "FREQ=MONTHLY;BYDAY=-1SU;COUNT=4",
        e5,
    )

    var e6 = List[Int64]()
    e6.append(1783155600)
    e6.append(1814691600)
    e6.append(1846314000)
    f += _check(
        "YEARLY Jul4 count3",
        DateTime(2026, 1, 1, 9, 0, 0),
        "FREQ=YEARLY;BYMONTH=7;BYMONTHDAY=4;COUNT=3",
        e6,
    )

    var e7 = List[Int64]()
    e7.append(1709208000)
    e7.append(1835438400)
    e7.append(1961668800)
    f += _check(
        "YEARLY leap Feb29 count3",
        DateTime(2024, 2, 29, 12, 0, 0),
        "FREQ=YEARLY;COUNT=3",
        e7,
    )

    var e8 = List[Int64]()
    e8.append(1767258000)
    e8.append(1767344400)
    e8.append(1767430800)
    e8.append(1767517200)
    e8.append(1767603600)
    f += _check(
        "DAILY UNTIL",
        DateTime(2026, 1, 1, 9, 0, 0),
        "FREQ=DAILY;UNTIL=20260105T090000",
        e8,
    )

    var e9 = List[Int64]()
    e9.append(1767686400)
    e9.append(1768896000)
    e9.append(1770105600)
    e9.append(1771315200)
    f += _check(
        "WEEKLY int2 TU count4",
        DateTime(2026, 1, 6, 8, 0, 0),
        "FREQ=WEEKLY;INTERVAL=2;BYDAY=TU;COUNT=4",
        e9,
    )

    var e10 = List[Int64]()
    e10.append(1795651200)
    e10.append(1827100800)
    e10.append(1858550400)
    f += _check(
        "YEARLY Thanksgiving count3",
        DateTime(2026, 1, 1, 0, 0, 0),
        "FREQ=YEARLY;BYMONTH=11;BYDAY=4TH;COUNT=3",
        e10,
    )

    var e11 = List[Int64]()
    e11.append(1768471200)
    e11.append(1776247200)
    e11.append(1784109600)
    e11.append(1792058400)
    f += _check(
        "MONTHLY int3 count4",
        DateTime(2026, 1, 15, 10, 0, 0),
        "FREQ=MONTHLY;INTERVAL=3;COUNT=4",
        e11,
    )

    # RFC 5545 §3.3.10 Note 1: BYDAY combined with BYMONTHDAY shifts BYDAY
    # from EXPAND to LIMIT — only days in BYMONTHDAY whose weekday matches a
    # BYDAY entry are emitted. Before the fix, chrono UNIONed the two sets
    # and emitted "every Monday" + "every 15th"; the correct behavior emits
    # only "Mondays-that-are-the-15th".
    var e_intersect = List[Int64]()
    e_intersect.append(1781514000)  # 2026-06-15 09:00 UTC (Mon)
    e_intersect.append(1802682000)  # 2027-02-15 09:00 UTC (Mon)
    e_intersect.append(1805101200)  # 2027-03-15 09:00 UTC (Mon)
    f += _check(
        "MONTHLY BYMONTHDAY+BYDAY intersect",
        DateTime(2026, 1, 1, 9, 0, 0),
        "FREQ=MONTHLY;BYMONTHDAY=15;BYDAY=MO;COUNT=3",
        e_intersect,
    )

    # RFC 5545 §3.3.10 WKST anchors the start-of-week for FREQ=WEEKLY. With
    # DTSTART on a Sunday and INTERVAL=2 + BYDAY=TU,SU, the chosen week-start
    # changes which Tue/Sun pair lands in the FIRST period: WKST=SU groups
    # the Sun and the following Tue into one week; WKST=MO (default) groups
    # the Tue BEFORE the Sun into the same week (so that Tue is filtered out
    # as < DTSTART and only the Sun emits in period 0).
    var e_wkst_su = List[Int64]()
    e_wkst_su.append(1767484800)  # 2026-01-04 00:00 UTC (Sun)
    e_wkst_su.append(1767657600)  # 2026-01-06 00:00 UTC (Tue)
    f += _check(
        "WEEKLY WKST=SU",
        DateTime(2026, 1, 4, 0, 0, 0),
        "FREQ=WEEKLY;INTERVAL=2;BYDAY=TU,SU;WKST=SU;COUNT=2",
        e_wkst_su,
    )

    var e_wkst_mo = List[Int64]()
    e_wkst_mo.append(1767484800)  # 2026-01-04 00:00 UTC (Sun)
    e_wkst_mo.append(1768262400)  # 2026-01-13 00:00 UTC (Tue, +9 days)
    f += _check(
        "WEEKLY WKST=MO (default)",
        DateTime(2026, 1, 4, 0, 0, 0),
        "FREQ=WEEKLY;INTERVAL=2;BYDAY=TU,SU;COUNT=2",
        e_wkst_mo,
    )

    # RFC 5545 §3.3.10: ordinal-prefixed BYDAY ("2TU", "-1FR", …) is only valid
    # with FREQ=MONTHLY or YEARLY. Reject — don't silently drop — when paired with
    # FREQ=DAILY or WEEKLY.
    var raised = False
    try:
        _ = RecurrenceRule.parse("FREQ=WEEKLY;BYDAY=2TU")
    except:
        raised = True
    if not raised:
        print("FAIL: WEEKLY+ordinal BYDAY was not rejected")
        f += 1
    raised = False
    try:
        _ = RecurrenceRule.parse("FREQ=DAILY;BYDAY=-1FR")
    except:
        raised = True
    if not raised:
        print("FAIL: DAILY+ordinal BYDAY was not rejected")
        f += 1
    # plain (no ordinal) BYDAY is still valid with WEEKLY
    var weekly_plain = RecurrenceRule.parse(
        "FREQ=WEEKLY;BYDAY=MO,WE,FR;COUNT=1"
    )
    if len(weekly_plain.occurrences(DateTime(2026, 1, 1, 9, 0, 0))) != 1:
        print("FAIL: plain BYDAY with WEEKLY broken")
        f += 1

    # DoS defense: `limit` must always cap emission. A hostile COUNT of two
    # billion must NOT be honored if the caller's limit is small.
    var hostile = RecurrenceRule.parse("FREQ=DAILY;COUNT=999999")
    var bounded = hostile.occurrences(DateTime(2026, 1, 1, 9, 0, 0), 5)
    if len(bounded) != 5:
        print("FAIL: limit not enforced when COUNT is large, got", len(bounded))
        f += 1

    # Adversarial parse-time rejections (RFC 5545 §3.3.10 + chrono's hardening).
    var rejects = [
        "FREQ=DAILY;COUNT=0",  # COUNT must be >= 1
        "FREQ=DAILY;COUNT=-5",  # negative COUNT
        "FREQ=DAILY;INTERVAL=0",  # INTERVAL must be >= 1
        "FREQ=DAILY;INTERVAL=10000",  # INTERVAL too large (overflow defense)
        "FREQ=DAILY;COUNT=5;UNTIL=20260105T090000",  # mutually exclusive
        "FREQ=DAILY;UNTIL=20260105T090000;COUNT=5",  # order doesn't matter
        "FREQ=MONTHLY;BYDAY=54MO",  # ordinal >53 (RFC range -53..53)
        "FREQ=MONTHLY;BYDAY=-54MO",  # ordinal <-53
        "FREQ=MONTHLY;BYMONTHDAY=0",  # 0 forbidden (RFC range -31..-1, 1..31)
        "FREQ=MONTHLY;BYMONTHDAY=32",  # > 31
        "FREQ=MONTHLY;BYMONTHDAY=-32",  # < -31
        # BYMONTH range (chrono enforces 1..12; silent acceptance was a defect)
        "FREQ=YEARLY;BYMONTH=0",
        "FREQ=YEARLY;BYMONTH=13",
        "FREQ=YEARLY;BYMONTH=-1",
        # Out-of-scope BY rules MUST raise (not silently drop) per chrono's
        # README pledge — one entry per documented key.
        "FREQ=DAILY;BYSETPOS=1",
        "FREQ=YEARLY;BYWEEKNO=10",
        "FREQ=YEARLY;BYYEARDAY=100",
        "FREQ=DAILY;BYHOUR=9",
        "FREQ=DAILY;BYMINUTE=30",
        "FREQ=DAILY;BYSECOND=0",
        # Sub-day frequencies (chrono represents day-and-up only).
        "FREQ=HOURLY",
        "FREQ=MINUTELY",
        "FREQ=SECONDLY",
    ]
    for i in range(len(rejects)):
        raised = False
        try:
            _ = RecurrenceRule.parse(rejects[i])
        except:
            raised = True
        if not raised:
            print("FAIL: not rejected:", rejects[i])
            f += 1

    # RFC 5545 §3.3.10: parameter NAMES are case-insensitive — `freq=daily`
    # must parse equivalently to `FREQ=DAILY`. (chrono case-folds the key but
    # not the value, since FREQ keywords and BYDAY tokens are spec-uppercase.)
    if (
        len(
            RecurrenceRule.parse("freq=DAILY;count=3").occurrences(
                DateTime(2026, 1, 1, 9, 0, 0)
            )
        )
        != 3
    ):
        print("FAIL: case-insensitive key not honored")
        f += 1

    # An unbounded rule (no COUNT / UNTIL) that reaches the `limit` ceiling
    # MUST raise — silently returning a truncated list (the audit defect)
    # left the caller unable to distinguish exhaustion from truncation.
    raised = False
    try:
        _ = RecurrenceRule.parse("FREQ=DAILY").occurrences(
            DateTime(2026, 1, 1, 9, 0, 0), 5
        )
    except:
        raised = True
    if not raised:
        print("FAIL: unbounded rule at limit didn't raise")
        f += 1

    if f == 0:
        print("test_rrule: PASS")
    return f
