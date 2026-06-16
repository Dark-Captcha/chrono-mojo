# Asia/Pyongyang — generated from IANA tzdata (2026b)
# 5 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime PYONGYANG = Timezone[5, 4](
    name="Asia/Pyongyang",
    area="Asia",
    location="Pyongyang",
    continent=Continent.ASIA,
    transitions=[
        -1948782180,
        -1830414600,
        -768646800,
        1439564400,
        1525446000,
    ],
    type_indices=[
        1,
        2,
        3,
        1,
        3,
    ],
    offsets=[
        30180,
        30600,
        32400,
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
