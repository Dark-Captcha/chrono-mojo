# ZonedDateTime: presenting an instant in a zone (DST-correct local fields +
# offset), the instant round-trip, equality of the same moment across zones, now(),
# from_local (building from wall-clock fields with PEP 495 fold/gap disambiguation),
# the full set of comparators (<, <=, >, >=, !=), and the field accessors
# (zone_name, date, time, nanosecond, weekday). Instants/offsets are the
# Python-zoneinfo-verified vectors.

from chrono.zoned_datetime import ZonedDateTime
from chrono.timezone import Timezone
from chrono.timezones.america.new_york import NEW_YORK
from chrono.timezones.asia.ho_chi_minh import HO_CHI_MINH
from chrono.timezones.europe.london import LONDON
from chrono.timezones.australia.sydney import SYDNEY
from chrono.datetime import DateTime
from chrono.enums import Weekday
from chrono.instant import Instant


def _check_local[
    transition_count: Int, type_count: Int
](
    timezone: Timezone[transition_count, type_count],
    year: Int,
    month: Int,
    day: Int,
    hour: Int,
    minute: Int,
    fold: Bool,
    expect_offset: Int,
    expect_instant: Int64,
) raises -> Int:
    var zoned = ZonedDateTime.from_local(
        DateTime(year, month, day, hour, minute, 0), timezone, fold
    )
    var f = 0
    if zoned.offset().total_seconds() != expect_offset:
        print(
            "FAIL from_local offset",
            timezone.name,
            hour,
            minute,
            "fold",
            fold,
            "got",
            zoned.offset().total_seconds(),
            "want",
            expect_offset,
        )
        f += 1
    if zoned.to_instant().seconds_since_epoch() != expect_instant:
        print(
            "FAIL from_local instant",
            timezone.name,
            hour,
            minute,
            "fold",
            fold,
            "got",
            zoned.to_instant().seconds_since_epoch(),
            "want",
            expect_instant,
        )
        f += 1
    # the requested wall-clock fields are preserved
    if zoned.hour() != hour or zoned.minute() != minute:
        print(
            "FAIL from_local fields not preserved",
            timezone.name,
            hour,
            minute,
        )
        f += 1
    return f


def run() raises -> Int:
    var f = 0

    # NY winter: instant -> 2026-01-15 12:00 local, offset -05:00 (EST)
    var winter = ZonedDateTime.from_instant(
        Instant.from_seconds_since_epoch(1768496400), NEW_YORK
    )
    if (
        winter.year() != 2026
        or winter.month().number() != 1
        or winter.day() != 15
        or winter.hour() != 12
        or winter.minute() != 0
        or winter.offset().total_seconds() != -18000
    ):
        print("FAIL NY winter local/offset")
        f += 1
    if winter.to_instant().seconds_since_epoch() != 1768496400:
        print("FAIL NY winter to_instant round-trip")
        f += 1

    # NY summer: offset -04:00 (EDT), same wall hour 12
    var summer = ZonedDateTime.from_instant(
        Instant.from_seconds_since_epoch(1784131200), NEW_YORK
    )
    if summer.hour() != 12 or summer.offset().total_seconds() != -14400:
        print("FAIL NY summer DST")
        f += 1

    # Asia/Ho_Chi_Minh: 12:00 local, +07:00
    var saigon = ZonedDateTime.from_instant(
        Instant.from_seconds_since_epoch(1781499600), HO_CHI_MINH
    )
    if saigon.hour() != 12 or saigon.offset().total_seconds() != 25200:
        print("FAIL Saigon local/offset")
        f += 1

    # the same moment in two zones is equal (compares by absolute instant)
    var moment = Instant.from_seconds_since_epoch(1781524800)
    if ZonedDateTime.from_instant(moment, LONDON) != ZonedDateTime.from_instant(
        moment, HO_CHI_MINH
    ):
        print("FAIL == across zones")
        f += 1

    # now()
    var current = ZonedDateTime.now(HO_CHI_MINH)
    if current.year() < 2024 or current.year() > 2100:
        print("FAIL now() out of range")
        f += 1

    # --- from_local: normal / gap / fold, both hemispheres, future (PEP 495 fold) ---
    f += _check_local(
        NEW_YORK, 2026, 6, 15, 12, 0, False, -14400, 1781539200
    )  # normal
    f += _check_local(
        NEW_YORK, 2026, 3, 8, 2, 30, False, -18000, 1772955000
    )  # gap, pre
    f += _check_local(
        NEW_YORK, 2026, 3, 8, 2, 30, True, -14400, 1772951400
    )  # gap, post
    f += _check_local(
        NEW_YORK, 2026, 11, 1, 1, 30, False, -14400, 1793511000
    )  # fold, first
    f += _check_local(
        NEW_YORK, 2026, 11, 1, 1, 30, True, -18000, 1793514600
    )  # fold, second
    f += _check_local(
        SYDNEY, 2026, 10, 4, 2, 30, False, 36000, 1791045000
    )  # south gap
    f += _check_local(SYDNEY, 2026, 10, 4, 2, 30, True, 39600, 1791041400)
    f += _check_local(
        SYDNEY, 2026, 4, 5, 2, 30, False, 39600, 1775316600
    )  # south fold
    f += _check_local(SYDNEY, 2026, 4, 5, 2, 30, True, 36000, 1775320200)
    f += _check_local(
        NEW_YORK, 2050, 3, 13, 2, 30, False, -18000, 2530769400
    )  # future gap
    f += _check_local(NEW_YORK, 2050, 3, 13, 2, 30, True, -14400, 2530765800)

    # --- accessors: zone_name / date / time / nanosecond / weekday ---
    # Monday 2026-06-15 14:30:45 UTC -> +07:00 = 2026-06-15 21:30:45 in Saigon.
    var monday_utc = Instant.from_seconds_since_epoch(1781533845)
    var monday_in_saigon = ZonedDateTime.from_instant(monday_utc, HO_CHI_MINH)
    if monday_in_saigon.zone_name() != "Asia/Ho_Chi_Minh":
        print("FAIL zone_name()", monday_in_saigon.zone_name())
        f += 1
    if monday_in_saigon.date() != DateTime(2026, 6, 15, 0, 0, 0).date():
        print("FAIL date() accessor")
        f += 1
    if (
        monday_in_saigon.time().hour() != 21
        or monday_in_saigon.time().minute() != 30
    ):
        print("FAIL time() accessor")
        f += 1
    if monday_in_saigon.nanosecond() != 0:
        print("FAIL nanosecond() accessor")
        f += 1
    if monday_in_saigon.weekday() != Weekday.MONDAY:
        print("FAIL weekday() accessor")
        f += 1

    # --- comparators: by absolute instant ---
    var earlier = ZonedDateTime.from_instant(
        Instant.from_seconds_since_epoch(1781499600), NEW_YORK
    )
    var same_moment_other_zone = ZonedDateTime.from_instant(
        Instant.from_seconds_since_epoch(1781499600), LONDON
    )
    var later = ZonedDateTime.from_instant(
        Instant.from_seconds_since_epoch(1781533845), HO_CHI_MINH
    )
    if not (earlier < later):
        print("FAIL __lt__")
        f += 1
    if not (later > earlier):
        print("FAIL __gt__")
        f += 1
    if not (earlier <= same_moment_other_zone):
        print("FAIL __le__ equal")
        f += 1
    if not (earlier <= later):
        print("FAIL __le__ strict")
        f += 1
    if not (later >= same_moment_other_zone):
        print("FAIL __ge__")
        f += 1
    if not (earlier != later):
        print("FAIL __ne__")
        f += 1
    if earlier != same_moment_other_zone:
        print("FAIL __ne__ same moment != self in another zone")
        f += 1

    # --- from_local preserves the nanosecond field ---
    # The local-lookup goes through `to_utc_instant().seconds_since_epoch()`,
    # which strips the sub-second part; the resulting offset is still correct
    # (offsets are second-aligned) and the original `DateTime` (with its
    # nanosecond) is stored verbatim, so `to_instant()` round-trips full
    # precision. Pin this property.
    var sub_second = ZonedDateTime.from_local(
        DateTime(2026, 6, 15, 14, 30, 45, 123_456_789), NEW_YORK
    )
    if sub_second.nanosecond() != 123_456_789:
        print("FAIL from_local lost nanosecond")
        f += 1
    if sub_second.to_instant().since_epoch().nanosecond() != 123_456_789:
        print("FAIL to_instant lost nanosecond")
        f += 1

    if f == 0:
        print("test_zoned: PASS")
    return f
