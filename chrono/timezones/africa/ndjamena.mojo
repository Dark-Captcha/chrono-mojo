# Africa/Ndjamena — generated from IANA tzdata (2026b)
# 3 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime NDJAMENA = Timezone[3, 3](
    name="Africa/Ndjamena",
    area="Africa",
    location="Ndjamena",
    continent=Continent.AFRICA,
    transitions=[
        -1830387612,
        308703600,
        321314400,
    ],
    type_indices=[
        1,
        2,
        1,
    ],
    offsets=[
        3612,
        3600,
        7200,
    ],
    is_dst=[
        0,
        0,
        1,
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
