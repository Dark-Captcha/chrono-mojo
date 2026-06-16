# Asia/Singapore — generated from IANA tzdata (2026b)
# 8 historical transitions, 8 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime SINGAPORE = Timezone[8, 8](
    name="Asia/Singapore",
    area="Asia",
    location="Singapore",
    continent=Continent.ASIA,
    transitions=[
        -2177477725,
        -2038200925,
        -1167634800,
        -1073028000,
        -894180000,
        -879665400,
        -767005200,
        378662400,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
        5,
        6,
        5,
        7,
    ],
    offsets=[
        24925,
        24925,
        25200,
        26400,
        26400,
        27000,
        32400,
        28800,
    ],
    is_dst=[
        0,
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
