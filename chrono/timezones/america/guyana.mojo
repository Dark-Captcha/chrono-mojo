# America/Guyana — generated from IANA tzdata (2026b)
# 4 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime GUYANA = Timezone[4, 5](
    name="America/Guyana",
    area="America",
    location="Guyana",
    continent=Continent.AMERICAS,
    transitions=[
        -1843589241,
        -1730577600,
        176096700,
        701841600,
    ],
    type_indices=[
        1,
        2,
        3,
        1,
    ],
    offsets=[
        -13959,
        -14400,
        -13500,
        -10800,
        -14400,
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
    posix_std_offset=-14400,
    posix_dst_offset=-14400,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
