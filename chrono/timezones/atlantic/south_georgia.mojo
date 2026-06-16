# Atlantic/South_Georgia — generated from IANA tzdata (2026b)
# 1 historical transitions, 2 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime SOUTH_GEORGIA = Timezone[1, 2](
    name="Atlantic/South_Georgia",
    area="Atlantic",
    location="South_Georgia",
    continent=Continent.ANTARCTICA,
    transitions=[
        -2524512832,
    ],
    type_indices=[
        1,
    ],
    offsets=[
        -8768,
        -7200,
    ],
    is_dst=[
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-7200,
    posix_dst_offset=-7200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
