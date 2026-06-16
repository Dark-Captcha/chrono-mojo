# Asia/Dhaka — generated from IANA tzdata (2026b)
# 7 historical transitions, 6 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime DHAKA = Timezone[7, 6](
    name="Asia/Dhaka",
    area="Asia",
    location="Dhaka",
    continent=Continent.ASIA,
    transitions=[
        -2524543300,
        -891582800,
        -872058600,
        -862637400,
        -576138600,
        1245430800,
        1262278800,
    ],
    type_indices=[
        1,
        2,
        3,
        2,
        4,
        5,
        4,
    ],
    offsets=[
        21700,
        21200,
        23400,
        19800,
        21600,
        25200,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
        0,
        1,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=21600,
    posix_dst_offset=21600,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
