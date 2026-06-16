# Asia/Colombo — generated from IANA tzdata (2026b)
# 8 historical transitions, 8 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime COLOMBO = Timezone[8, 8](
    name="Asia/Colombo",
    area="Asia",
    location="Colombo",
    continent=Continent.ASIA,
    transitions=[
        -2840159964,
        -2019705572,
        -883287000,
        -862639200,
        -764051400,
        832962600,
        846266400,
        1145039400,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
        2,
        5,
        6,
        2,
    ],
    offsets=[
        19164,
        19172,
        19800,
        21600,
        23400,
        23400,
        21600,
        19800,
    ],
    is_dst=[
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=19800,
    posix_dst_offset=19800,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
