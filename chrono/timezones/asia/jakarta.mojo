# Asia/Jakarta — generated from IANA tzdata (2026b)
# 8 historical transitions, 7 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime JAKARTA = Timezone[8, 7](
    name="Asia/Jakarta",
    area="Asia",
    location="Jakarta",
    continent=Continent.ASIA,
    transitions=[
        -3231299232,
        -1451719200,
        -1172906400,
        -876641400,
        -766054800,
        -683883000,
        -620812800,
        -189415800,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
        3,
        5,
        3,
        6,
    ],
    offsets=[
        25632,
        25632,
        26400,
        27000,
        32400,
        28800,
        25200,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=25200,
    posix_dst_offset=25200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
