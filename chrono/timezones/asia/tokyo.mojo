# Asia/Tokyo — generated from IANA tzdata (2026b)
# 9 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime TOKYO = Timezone[9, 4](
    name="Asia/Tokyo",
    area="Asia",
    location="Tokyo",
    continent=Continent.ASIA,
    transitions=[
        -2587712400,
        -683802000,
        -672310800,
        -654771600,
        -640861200,
        -620298000,
        -609411600,
        -588848400,
        -577962000,
    ],
    type_indices=[
        3,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
    ],
    offsets=[
        33539,
        36000,
        32400,
        32400,
    ],
    is_dst=[
        0,
        1,
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
