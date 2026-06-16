# Africa/Conakry — generated from IANA tzdata (2026b)
# 1 historical transitions, 2 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime CONAKRY = Timezone[1, 2](
    name="Africa/Conakry",
    area="Africa",
    location="Conakry",
    continent=Continent.AFRICA,
    transitions=[
        -1830383032,
    ],
    type_indices=[
        1,
    ],
    offsets=[
        -968,
        0,
    ],
    is_dst=[
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=0,
    posix_dst_offset=0,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
