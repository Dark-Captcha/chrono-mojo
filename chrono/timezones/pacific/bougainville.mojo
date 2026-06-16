# Pacific/Bougainville — generated from IANA tzdata (2026b)
# 5 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime BOUGAINVILLE = Timezone[5, 5](
    name="Pacific/Bougainville",
    area="Pacific",
    location="Bougainville",
    continent=Continent.OCEANIA,
    transitions=[
        -2840178136,
        -2366790512,
        -868010400,
        -768906000,
        1419696000,
    ],
    type_indices=[
        1,
        2,
        3,
        2,
        4,
    ],
    offsets=[
        37336,
        35312,
        36000,
        32400,
        39600,
    ],
    is_dst=[
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
