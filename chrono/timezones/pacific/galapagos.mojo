# Pacific/Galapagos — generated from IANA tzdata (2026b)
# 4 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime GALAPAGOS = Timezone[4, 4](
    name="Pacific/Galapagos",
    area="Pacific",
    location="Galapagos",
    continent=Continent.OCEANIA,
    transitions=[
        -1230746496,
        504939600,
        722930400,
        728888400,
    ],
    type_indices=[
        1,
        3,
        2,
        3,
    ],
    offsets=[
        -21504,
        -18000,
        -18000,
        -21600,
    ],
    is_dst=[
        0,
        0,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-21600,
    posix_dst_offset=-21600,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
