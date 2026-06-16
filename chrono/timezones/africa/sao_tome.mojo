# Africa/Sao_Tome — generated from IANA tzdata (2026b)
# 4 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime SAO_TOME = Timezone[4, 5](
    name="Africa/Sao_Tome",
    area="Africa",
    location="Sao_Tome",
    continent=Continent.AFRICA,
    transitions=[
        -2713912016,
        -1830384000,
        1514768400,
        1546304400,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
    ],
    offsets=[
        1616,
        -2205,
        0,
        3600,
        0,
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
    posix_std_offset=0,
    posix_dst_offset=0,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
