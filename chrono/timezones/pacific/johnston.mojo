# Pacific/Johnston — generated from IANA tzdata (2026b)
# 7 historical transitions, 6 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime JOHNSTON = Timezone[7, 6](
    name="Pacific/Johnston",
    area="Pacific",
    location="Johnston",
    continent=Continent.OCEANIA,
    transitions=[
        -2334101314,
        -1157283000,
        -1155436200,
        -880198200,
        -769395600,
        -765376200,
        -712150200,
    ],
    type_indices=[
        1,
        2,
        1,
        3,
        4,
        1,
        5,
    ],
    offsets=[
        -37886,
        -37800,
        -34200,
        -34200,
        -34200,
        -36000,
    ],
    is_dst=[
        0,
        0,
        1,
        1,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-36000,
    posix_dst_offset=-36000,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
