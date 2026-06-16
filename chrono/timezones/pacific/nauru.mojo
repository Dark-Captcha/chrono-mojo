# Pacific/Nauru — generated from IANA tzdata (2026b)
# 4 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime NAURU = Timezone[4, 4](
    name="Pacific/Nauru",
    area="Pacific",
    location="Nauru",
    continent=Continent.OCEANIA,
    transitions=[
        -1545131260,
        -862918200,
        -767350800,
        287418600,
    ],
    type_indices=[
        1,
        2,
        1,
        3,
    ],
    offsets=[
        40060,
        41400,
        32400,
        43200,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=43200,
    posix_dst_offset=43200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
