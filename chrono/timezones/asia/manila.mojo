# Asia/Manila — generated from IANA tzdata (2026b)
# 14 historical transitions, 7 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime MANILA = Timezone[14, 7](
    name="Asia/Manila",
    area="Asia",
    location="Manila",
    continent=Continent.ASIA,
    transitions=[
        -3944621032,
        -2219083200,
        -1046678400,
        -1040115600,
        -885024000,
        -880016400,
        -783594000,
        -760093200,
        -496224000,
        -491562000,
        228326400,
        243702000,
        643219200,
        649177200,
    ],
    type_indices=[
        1,
        4,
        2,
        3,
        2,
        5,
        2,
        3,
        2,
        3,
        2,
        3,
        2,
        3,
    ],
    offsets=[
        -57368,
        29032,
        32400,
        28800,
        28800,
        32400,
        28800,
    ],
    is_dst=[
        0,
        0,
        1,
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
