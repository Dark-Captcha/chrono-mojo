# America/El_Salvador — generated from IANA tzdata (2026b)
# 5 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime EL_SALVADOR = Timezone[5, 3](
    name="America/El_Salvador",
    area="America",
    location="El_Salvador",
    continent=Continent.AMERICAS,
    transitions=[
        -1546279392,
        547020000,
        559717200,
        578469600,
        591166800,
    ],
    type_indices=[
        2,
        1,
        2,
        1,
        2,
    ],
    offsets=[
        -21408,
        -18000,
        -21600,
    ],
    is_dst=[
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
