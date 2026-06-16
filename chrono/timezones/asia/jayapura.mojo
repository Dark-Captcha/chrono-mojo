# Asia/Jayapura — generated from IANA tzdata (2026b)
# 3 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime JAYAPURA = Timezone[3, 4](
    name="Asia/Jayapura",
    area="Asia",
    location="Jayapura",
    continent=Continent.ASIA,
    transitions=[
        -1172913768,
        -799491600,
        -189423000,
    ],
    type_indices=[
        1,
        2,
        3,
    ],
    offsets=[
        33768,
        32400,
        34200,
        32400,
    ],
    is_dst=[
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
