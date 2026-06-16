# America/Martinique — generated from IANA tzdata (2026b)
# 4 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime MARTINIQUE = Timezone[4, 4](
    name="America/Martinique",
    area="America",
    location="Martinique",
    continent=Continent.AMERICAS,
    transitions=[
        -2524506940,
        -1851537340,
        323841600,
        338958000,
    ],
    type_indices=[
        1,
        2,
        3,
        2,
    ],
    offsets=[
        -14660,
        -14660,
        -14400,
        -10800,
    ],
    is_dst=[
        0,
        0,
        0,
        1,
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
