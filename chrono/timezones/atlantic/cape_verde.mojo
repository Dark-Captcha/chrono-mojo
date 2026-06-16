# Atlantic/Cape_Verde — generated from IANA tzdata (2026b)
# 4 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime CAPE_VERDE = Timezone[4, 5](
    name="Atlantic/Cape_Verde",
    area="Atlantic",
    location="Cape_Verde",
    continent=Continent.AFRICA,
    transitions=[
        -1830376800,
        -862610400,
        -764118000,
        186120000,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
    ],
    offsets=[
        -5644,
        -7200,
        -3600,
        -7200,
        -3600,
    ],
    is_dst=[
        0,
        0,
        1,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-3600,
    posix_dst_offset=-3600,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
