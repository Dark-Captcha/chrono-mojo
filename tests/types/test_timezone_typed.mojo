# Typed Timezone[N, T] — verify offset_at gives the expected offset at
# representative instants. Vectors are pinned KAT, captured from Python `zoneinfo`
# at vector-generation time; the source of truth in this repo is the
# comptime-baked transition table in chrono/timezones/<area>/<name>.mojo.
# Regenerate by hand against `zoneinfo` if tzdata advances. Coverage:
#   permanent-offset zones .... Asia/Ho_Chi_Minh, Asia/Bangkok (+07 since 1975)
#   DST history ............... America/New_York (EST/EDT), Europe/London (BST)
#   southern hemisphere ....... Australia/Sydney (AEST/AEDT)
#   POSIX-future extrapolation. NY 2050 (rule, not transition table)
#   zero-transition zone ...... Etc/UTC (the comptime-if branch in offset_at)
#   pre-first-transition zone . Asia/Bangkok LMT pre-1880 (the linear-find branch)
#   IANA link aliases ......... GB, JAPAN, CUBA, EST, EST5EDT, EIRE, UCT

from chrono.timezones.asia.ho_chi_minh import HO_CHI_MINH
from chrono.timezones.asia.bangkok import BANGKOK
from chrono.timezones.america.new_york import NEW_YORK
from chrono.timezones.america.iqaluit import IQALUIT
from chrono.timezones.europe.london import LONDON
from chrono.timezones.australia.sydney import SYDNEY
from chrono.timezones.etc.utc import UTC
from chrono.timezones.aliases import GB, JAPAN, CUBA, EST, EST5EDT, EIRE, UCT


def _check(
    label: String, instant_seconds: Int64, got: Int32, want: Int
) raises -> Int:
    if Int(got) != want:
        print(
            "FAIL typed Timezone",
            label,
            "@",
            instant_seconds,
            "got:",
            got,
            "want:",
            want,
        )
        return 1
    return 0


def run() raises -> Int:
    var f = 0

    # Permanent +07:00 since 1975
    f += _check(
        "Asia/Ho_Chi_Minh",
        1781499600,
        HO_CHI_MINH.offset_at(1781499600),
        25200,
    )
    f += _check(
        "Asia/Bangkok", 1781499600, BANGKOK.offset_at(1781499600), 25200
    )

    # New York DST: EST (-05:00 / -18000) winter, EDT (-04:00 / -14400) summer
    f += _check(
        "America/New_York winter",
        1768496400,
        NEW_YORK.offset_at(1768496400),
        -18000,
    )
    f += _check(
        "America/New_York summer",
        1784131200,
        NEW_YORK.offset_at(1784131200),
        -14400,
    )

    # London BST (+01:00 / 3600) summer
    f += _check(
        "Europe/London summer",
        1784113200,
        LONDON.offset_at(1784113200),
        3600,
    )

    # Sydney (southern hemisphere): AEDT (+11:00 / 39600) Jan, AEST (+10:00 / 36000) Jul
    f += _check(
        "Australia/Sydney summer",
        1768438800,
        SYDNEY.offset_at(1768438800),
        39600,
    )
    f += _check(
        "Australia/Sydney winter",
        1784080800,
        SYDNEY.offset_at(1784080800),
        36000,
    )

    # POSIX-future (2050) — past the final transition; offset comes from the
    # inline POSIX footer rule, not the transition table.
    f += _check(
        "America/New_York 2050 summer",
        2540304000,
        NEW_YORK.offset_at(2540304000),
        -14400,
    )
    f += _check(
        "America/New_York 2050 winter",
        2524669200,
        NEW_YORK.offset_at(2524669200),
        -18000,
    )

    # Zero-transition zone — Etc/UTC has Timezone[0, 1] and exercises the
    # `comptime if Self.transition_count == 0:` branch in offset_at. Offset
    # is always 0 regardless of the instant.
    f += _check("Etc/UTC @ epoch", 0, UTC.offset_at(0), 0)
    f += _check("Etc/UTC future", 2540304000, UTC.offset_at(2540304000), 0)

    # Pre-first-transition — for an instant strictly before transitions[0],
    # offset_at finds the first non-DST type (LMT-ish). Asia/Bangkok's first
    # transition is at -2840164924; -3_000_000_000 sits comfortably before it.
    # The first non-DST type for Bangkok is offsets[0] = 24124 (+06:42:04 LMT).
    f += _check(
        "Asia/Bangkok pre-first LMT",
        -3000000000,
        BANGKOK.offset_at(-3000000000),
        24124,
    )
    # And the harder branch: America/Iqaluit's first transition (-865296000)
    # goes INTO a DST type (type_indices[0]=4, is_dst[4]=1). Before the
    # transition we must skip that type and find the first non-DST entry —
    # offsets[0]=0 (IANA's `zzz` sentinel for "no civil time" pre-1942).
    # A naive "use offsets[type_indices[0]]" would return -14400, hiding
    # the LMT/pre-history convention.
    f += _check(
        "America/Iqaluit pre-1942 zzz",
        -1000000000,
        IQALUIT.offset_at(-1000000000),
        0,
    )

    # IANA link aliases: GB === Europe/London, JAPAN === Asia/Tokyo (+09:00),
    # CUBA === America/Havana (CST -05:00 winter), EST === America/Panama
    # (fixed -05:00), EST5EDT === America/New_York (US DST pattern),
    # EIRE === Europe/Dublin (0 in winter, +01:00 in summer), UCT === Etc/UTC.
    f += _check(
        "GB === Europe/London summer",
        1784113200,
        GB.offset_at(1784113200),
        3600,
    )
    f += _check(
        "JAPAN === Asia/Tokyo",
        1781492400,
        JAPAN.offset_at(1781492400),
        32400,
    )
    f += _check(
        "CUBA === America/Havana winter",
        1768496400,
        CUBA.offset_at(1768496400),
        -18000,
    )
    f += _check(
        "EST === America/Panama (fixed -05:00)",
        1781499600,
        EST.offset_at(1781499600),
        -18000,
    )
    f += _check(
        "EST5EDT === America/New_York winter",
        1768496400,
        EST5EDT.offset_at(1768496400),
        -18000,
    )
    f += _check(
        "EIRE === Europe/Dublin winter",
        1768496400,
        EIRE.offset_at(1768496400),
        0,
    )
    f += _check("UCT === Etc/UTC", 1781499600, UCT.offset_at(1781499600), 0)

    # `Timezone.local_lookup` was previously exercised only indirectly through
    # ZonedDateTime.from_local. Hit it directly so a future refactor that
    # removes the from_local seam still keeps the fold/gap logic covered.
    # `local_seconds` is the wall-clock time treated as if UTC (epoch-seconds
    # form), matching what `ZonedDateTime.from_local` feeds in.
    #
    # 2026-03-08 02:30 in NY is in the spring-forward gap (DST jumps 02:00 ->
    # 03:00 EDT). fold=False returns the pre-gap EST offset, fold=True the
    # post-gap EDT offset.
    var ny_gap_local = Int64(1772937000)  # 2026-03-08 02:30:00 local-as-UTC
    f += _check(
        "NY local_lookup 02:30 gap fold=0 -> EST",
        ny_gap_local,
        NEW_YORK.local_lookup(ny_gap_local, False),
        -18000,
    )
    f += _check(
        "NY local_lookup 02:30 gap fold=1 -> EDT",
        ny_gap_local,
        NEW_YORK.local_lookup(ny_gap_local, True),
        -14400,
    )
    # 2026-11-01 01:30 in NY is the fall-back fold (01:00-01:59 happens twice).
    # fold=False picks the EARLIER occurrence (larger EDT offset).
    var ny_fold_local = Int64(1793496600)  # 2026-11-01 01:30:00 local-as-UTC
    f += _check(
        "NY local_lookup 01:30 fold fold=0 -> EDT (first)",
        ny_fold_local,
        NEW_YORK.local_lookup(ny_fold_local, False),
        -14400,
    )
    f += _check(
        "NY local_lookup 01:30 fold fold=1 -> EST (second)",
        ny_fold_local,
        NEW_YORK.local_lookup(ny_fold_local, True),
        -18000,
    )

    if f == 0:
        print("test_timezone_typed: PASS")
    return f
