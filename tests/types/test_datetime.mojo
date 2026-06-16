# DateTime: field decode, the UTC Instant projection (differential vs Python
# datetime timestamps), exact arithmetic across day boundaries, difference, and
# comparison.

from chrono.datetime import DateTime
from chrono.instant import Instant
from chrono.duration import Duration


def _check_unix(
    year: Int,
    month: Int,
    day: Int,
    hour: Int,
    minute: Int,
    second: Int,
    unix: Int64,
) raises -> Int:
    var f = 0
    var d = DateTime(year, month, day, hour, minute, second)
    if d.to_utc_instant().seconds_since_epoch() != unix:
        print(
            "FAIL to_utc_instant",
            year,
            month,
            day,
            "got",
            d.to_utc_instant().seconds_since_epoch(),
            "want",
            unix,
        )
        f += 1
    if DateTime.from_utc_instant(Instant.from_seconds_since_epoch(unix)) != d:
        print("FAIL from_utc_instant round-trip", unix)
        f += 1
    return f


def run() raises -> Int:
    var f = 0

    # --- field decode ---
    var sample = DateTime(2026, 6, 15, 14, 30, 45, 500_000_000)
    if (
        sample.year() != 2026
        or sample.month().number() != 6
        or sample.day() != 15
        or sample.hour() != 14
        or sample.minute() != 30
        or sample.second() != 45
        or sample.nanosecond() != 500_000_000
    ):
        print("FAIL DateTime field decode")
        f += 1

    # --- UTC projection (differential vs Python datetime) ---
    f += _check_unix(1970, 1, 1, 0, 0, 0, 0)
    f += _check_unix(2026, 6, 15, 14, 30, 45, 1781533845)
    f += _check_unix(2000, 1, 1, 12, 0, 0, 946728000)
    f += _check_unix(1969, 12, 31, 23, 59, 59, -1)

    # --- exact arithmetic across boundaries ---
    var later = DateTime(2026, 6, 15, 23, 30, 0) + Duration.from_hours(1)
    if (
        later.day() != 16
        or later.hour() != 0
        or later.minute() != 30
        or later.month().number() != 6
    ):
        print("FAIL + duration across midnight")
        f += 1
    var earlier = DateTime(2026, 6, 16, 0, 30, 0) - Duration.from_hours(1)
    if earlier.day() != 15 or earlier.hour() != 23:
        print("FAIL - duration across midnight")
        f += 1
    if (
        DateTime(2026, 6, 15, 14, 30, 45) - DateTime(2026, 6, 15, 14, 30, 0)
    ).total_seconds() != 45:
        print("FAIL datetime - datetime")
        f += 1

    # --- comparison ---
    if not (DateTime(2026, 6, 15, 0, 0, 0) < DateTime(2026, 6, 15, 0, 0, 1)):
        print("FAIL cmp by time")
        f += 1
    if not (DateTime(2026, 1, 1) < DateTime(2026, 1, 2)):
        print("FAIL cmp by date")
        f += 1
    if not (
        DateTime(2026, 6, 15, 14, 30, 45) == DateTime(2026, 6, 15, 14, 30, 45)
    ):
        print("FAIL cmp ==")
        f += 1

    if f == 0:
        print("test_datetime: PASS")
    return f
