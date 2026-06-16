# Asia/Dili — generated from IANA tzdata (2026b)
# 4 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime DILI = Timezone[4, 5](
    name="Asia/Dili",
    area="Asia",
    location="Dili",
    continent=Continent.ASIA,
    transitions=[
        -1830412800,
        -879152400,
        199897200,
        969120000,
    ],
    type_indices=[
        1,
        2,
        3,
        2,
    ],
    offsets=[
        30140,
        28800,
        32400,
        28800,
        32400,
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
    posix_std_offset=32400,
    posix_dst_offset=32400,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
