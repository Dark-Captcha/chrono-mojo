# Asia/Ujung_Pandang — generated from IANA tzdata (2026b)
# 4 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime UJUNG_PANDANG = Timezone[4, 5](
    name="Asia/Ujung_Pandang",
    area="Asia",
    location="Ujung_Pandang",
    continent=Continent.ASIA,
    transitions=[
        -1577951856,
        -1172908656,
        -880272000,
        -766054800,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
    ],
    offsets=[
        28656,
        28656,
        28800,
        32400,
        28800,
    ],
    is_dst=[
        0,
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
