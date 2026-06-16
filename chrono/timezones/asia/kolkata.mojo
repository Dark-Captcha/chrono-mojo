# Asia/Kolkata — generated from IANA tzdata (2026b)
# 7 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime KOLKATA = Timezone[7, 5](
    name="Asia/Kolkata",
    area="Asia",
    location="Kolkata",
    continent=Continent.ASIA,
    transitions=[
        -3645237208,
        -3155694800,
        -2019705670,
        -891581400,
        -872058600,
        -862637400,
        -764145000,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
        3,
        4,
        3,
    ],
    offsets=[
        21208,
        21200,
        19270,
        19800,
        23400,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
        1,
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
