# America/Bogota — generated from IANA tzdata (2026b)
# 4 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime BOGOTA = Timezone[4, 4](
    name="America/Bogota",
    area="America",
    location="Bogota",
    continent=Continent.AMERICAS,
    transitions=[
        -2707671824,
        -1739041424,
        704869200,
        729057600,
    ],
    type_indices=[
        1,
        3,
        2,
        3,
    ],
    offsets=[
        -17776,
        -17776,
        -14400,
        -18000,
    ],
    is_dst=[
        0,
        0,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-18000,
    posix_dst_offset=-18000,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
