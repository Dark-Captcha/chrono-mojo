# Antarctica/Casey — generated from IANA tzdata (2026b)
# 17 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime CASEY = Timezone[17, 4](
    name="Antarctica/Casey",
    area="Antarctica",
    location="Casey",
    continent=Continent.ANTARCTICA,
    transitions=[
        -31536000,
        1255802400,
        1267714800,
        1319738400,
        1329843600,
        1477065600,
        1520701200,
        1538856000,
        1552752000,
        1570129200,
        1583596800,
        1601740860,
        1615640400,
        1633190460,
        1647090000,
        1664640060,
        1678291200,
    ],
    type_indices=[
        1,
        2,
        1,
        2,
        3,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
    ],
    offsets=[
        0,
        28800,
        39600,
        28800,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=28800,
    posix_dst_offset=28800,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
