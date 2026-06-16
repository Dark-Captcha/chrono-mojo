# Indian/Mauritius — generated from IANA tzdata (2026b)
# 5 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime MAURITIUS = Timezone[5, 3](
    name="Indian/Mauritius",
    area="Indian",
    location="Mauritius",
    continent=Continent.AFRICA,
    transitions=[
        -1988164200,
        403041600,
        417034800,
        1224972000,
        1238274000,
    ],
    type_indices=[
        2,
        1,
        2,
        1,
        2,
    ],
    offsets=[
        13800,
        18000,
        14400,
    ],
    is_dst=[
        0,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=14400,
    posix_dst_offset=14400,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
