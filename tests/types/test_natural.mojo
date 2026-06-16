# NaturalDate: the bounded natural-language grammar, resolved against a fixed
# reference (Monday 2026-06-15 14:30:45). KAT (heuristic feature, no external oracle).
# "next/last <weekday>" mean the strictly-next / strictly-previous such weekday.

from chrono.natural import NaturalDate
from chrono.datetime import DateTime


def _check(
    name: String,
    got: DateTime,
    year: Int,
    month: Int,
    day: Int,
    hour: Int,
    minute: Int,
    second: Int,
) raises -> Int:
    if got != DateTime(year, month, day, hour, minute, second):
        print(
            "FAIL",
            name,
            "got",
            got.year(),
            got.month().number(),
            got.day(),
            got.hour(),
            got.minute(),
            got.second(),
        )
        return 1
    return 0


def _rejects(text: String, reference: DateTime) raises -> Int:
    try:
        _ = NaturalDate.parse(text, reference)
    except:
        return 0
    print("FAIL accepted off-grammar:", text)
    return 1


def run() raises -> Int:
    var f = 0
    var reference = DateTime(2026, 6, 15, 14, 30, 45)  # a Monday

    f += _check(
        "now", NaturalDate.parse("now", reference), 2026, 6, 15, 14, 30, 45
    )
    f += _check(
        "today", NaturalDate.parse("today", reference), 2026, 6, 15, 0, 0, 0
    )
    f += _check(
        "tomorrow",
        NaturalDate.parse("Tomorrow", reference),
        2026,
        6,
        16,
        0,
        0,
        0,
    )
    f += _check(
        "yesterday",
        NaturalDate.parse("yesterday", reference),
        2026,
        6,
        14,
        0,
        0,
        0,
    )

    f += _check(
        "in 3 days",
        NaturalDate.parse("in 3 days", reference),
        2026,
        6,
        18,
        14,
        30,
        45,
    )
    f += _check(
        "in 2 hours",
        NaturalDate.parse("in 2 hours", reference),
        2026,
        6,
        15,
        16,
        30,
        45,
    )
    f += _check(
        "5 minutes ago",
        NaturalDate.parse("5 minutes ago", reference),
        2026,
        6,
        15,
        14,
        25,
        45,
    )
    f += _check(
        "in 1 week",
        NaturalDate.parse("in 1 week", reference),
        2026,
        6,
        22,
        14,
        30,
        45,
    )
    f += _check(
        "2 months ago",
        NaturalDate.parse("2 months ago", reference),
        2026,
        4,
        15,
        14,
        30,
        45,
    )
    f += _check(
        "in 1 year",
        NaturalDate.parse("in 1 year", reference),
        2027,
        6,
        15,
        14,
        30,
        45,
    )

    # weekday navigation (reference is Monday Jun 15)
    f += _check(
        "next monday",
        NaturalDate.parse("next monday", reference),
        2026,
        6,
        22,
        0,
        0,
        0,
    )
    f += _check(
        "next friday",
        NaturalDate.parse("next friday", reference),
        2026,
        6,
        19,
        0,
        0,
        0,
    )
    f += _check(
        "last friday",
        NaturalDate.parse("last friday", reference),
        2026,
        6,
        12,
        0,
        0,
        0,
    )
    f += _check(
        "last monday",
        NaturalDate.parse("last monday", reference),
        2026,
        6,
        8,
        0,
        0,
        0,
    )

    # off-grammar rejection
    f += _rejects("", reference)
    f += _rejects("in 3 fortnights", reference)
    f += _rejects("someday soon", reference)
    f += _rejects("next blursday", reference)
    # Count must be strictly positive — the grammar carries polarity in the
    # marker word, so a signed/zero N is a malformed input rather than a
    # silent no-op or sign-flip.
    f += _rejects("in 0 days", reference)
    f += _rejects("in -3 days", reference)
    f += _rejects("0 days ago", reference)
    f += _rejects("-3 days ago", reference)

    if f == 0:
        print("test_natural: PASS")
    return f
