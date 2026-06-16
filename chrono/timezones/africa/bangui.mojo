# Africa/Bangui — generated from IANA tzdata (2026b)
# 4 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime BANGUI = Timezone[4, 4](
    name="Africa/Bangui",
    area="Africa",
    location="Bangui",
    continent=Continent.AFRICA,
    transitions=[
        -2035584815,
        -1940889600,
        -1767226415,
        -1588465800,
    ],
    type_indices=[
        1,
        0,
        2,
        3,
    ],
    offsets=[
        815,
        0,
        1800,
        3600,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=3600,
    posix_dst_offset=3600,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
