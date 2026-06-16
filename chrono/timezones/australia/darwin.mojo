# Australia/Darwin — generated from IANA tzdata (2026b)
# 10 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime DARWIN = Timezone[10, 5](
    name="Australia/Darwin",
    area="Australia",
    location="Darwin",
    continent=Continent.OCEANIA,
    transitions=[
        -2364108200,
        -2230189200,
        -1672558200,
        -1665387000,
        -883639800,
        -876123000,
        -860398200,
        -844673400,
        -828343800,
        -813223800,
    ],
    type_indices=[
        1,
        4,
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
        31400,
        32400,
        37800,
        34200,
        34200,
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
    posix_std_offset=34200,
    posix_dst_offset=34200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
