# Pacific/Kiritimati — generated from IANA tzdata (2026b)
# 3 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime KIRITIMATI = Timezone[3, 4](
    name="Pacific/Kiritimati",
    area="Pacific",
    location="Kiritimati",
    continent=Continent.OCEANIA,
    transitions=[
        -2177415040,
        307622400,
        788868000,
    ],
    type_indices=[
        1,
        2,
        3,
    ],
    offsets=[
        -37760,
        -38400,
        -36000,
        50400,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=50400,
    posix_dst_offset=50400,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
