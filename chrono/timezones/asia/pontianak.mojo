# Asia/Pontianak — generated from IANA tzdata (2026b)
# 8 historical transitions, 7 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime PONTIANAK = Timezone[8, 7](
    name="Asia/Pontianak",
    area="Asia",
    location="Pontianak",
    continent=Continent.ASIA,
    transitions=[
        -1946186240,
        -1172906240,
        -881220600,
        -766054800,
        -683883000,
        -620812800,
        -189415800,
        567964800,
    ],
    type_indices=[
        1,
        2,
        3,
        2,
        4,
        2,
        5,
        6,
    ],
    offsets=[
        26240,
        26240,
        27000,
        32400,
        28800,
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
