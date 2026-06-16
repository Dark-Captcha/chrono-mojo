# America/Costa_Rica — generated from IANA tzdata (2026b)
# 10 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime COSTA_RICA = Timezone[10, 4](
    name="America/Costa_Rica",
    area="America",
    location="Costa_Rica",
    continent=Continent.AMERICAS,
    transitions=[
        -2524501427,
        -1545071027,
        288770400,
        297234000,
        320220000,
        328683600,
        664264800,
        678344400,
        695714400,
        700635600,
    ],
    type_indices=[
        1,
        3,
        2,
        3,
        2,
        3,
        2,
        3,
        2,
        3,
    ],
    offsets=[
        -20173,
        -20173,
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
