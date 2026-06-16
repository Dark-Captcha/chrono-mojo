# Pacific/Kwajalein — generated from IANA tzdata (2026b)
# 6 historical transitions, 6 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime KWAJALEIN = Timezone[6, 6](
    name="Pacific/Kwajalein",
    area="Pacific",
    location="Kwajalein",
    continent=Continent.OCEANIA,
    transitions=[
        -2177492960,
        -1041418800,
        -907408800,
        -817462800,
        -7988400,
        745934400,
    ],
    type_indices=[
        1,
        2,
        3,
        1,
        4,
        5,
    ],
    offsets=[
        40160,
        39600,
        36000,
        32400,
        -43200,
        43200,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=43200,
    posix_dst_offset=43200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
