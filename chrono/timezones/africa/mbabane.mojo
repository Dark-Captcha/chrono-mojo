# Africa/Mbabane — generated from IANA tzdata (2026b)
# 6 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime MBABANE = Timezone[6, 4](
    name="Africa/Mbabane",
    area="Africa",
    location="Mbabane",
    continent=Continent.AFRICA,
    transitions=[
        -2458173120,
        -2109288600,
        -860976000,
        -845254800,
        -829526400,
        -813805200,
    ],
    type_indices=[
        1,
        3,
        2,
        3,
        2,
        3,
    ],
    offsets=[
        6720,
        5400,
        10800,
        7200,
    ],
    is_dst=[
        0,
        0,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=7200,
    posix_dst_offset=7200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
