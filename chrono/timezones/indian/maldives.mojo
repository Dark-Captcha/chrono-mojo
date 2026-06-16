# Indian/Maldives — generated from IANA tzdata (2026b)
# 2 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime MALDIVES = Timezone[2, 3](
    name="Indian/Maldives",
    area="Indian",
    location="Maldives",
    continent=Continent.ASIA,
    transitions=[
        -2840158440,
        -315636840,
    ],
    type_indices=[
        1,
        2,
    ],
    offsets=[
        17640,
        17640,
        18000,
    ],
    is_dst=[
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=18000,
    posix_dst_offset=18000,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
