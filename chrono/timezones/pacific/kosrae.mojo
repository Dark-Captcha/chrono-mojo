# Pacific/Kosrae — generated from IANA tzdata (2026b)
# 9 historical transitions, 7 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime KOSRAE = Timezone[9, 7](
    name="Pacific/Kosrae",
    area="Pacific",
    location="Kosrae",
    continent=Continent.OCEANIA,
    transitions=[
        -3944631116,
        -2177491916,
        -1743678000,
        -1606813200,
        -1041418800,
        -907408800,
        -770634000,
        -7988400,
        915105600,
    ],
    type_indices=[
        1,
        2,
        3,
        2,
        4,
        3,
        2,
        5,
        2,
    ],
    offsets=[
        -47284,
        39116,
        39600,
        32400,
        36000,
        43200,
        39600,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=39600,
    posix_dst_offset=39600,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
