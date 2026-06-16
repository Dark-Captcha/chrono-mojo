# Pacific/Pitcairn — generated from IANA tzdata (2026b)
# 2 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime PITCAIRN = Timezone[2, 3](
    name="Pacific/Pitcairn",
    area="Pacific",
    location="Pitcairn",
    continent=Continent.OCEANIA,
    transitions=[
        -2177421580,
        893665800,
    ],
    type_indices=[
        1,
        2,
    ],
    offsets=[
        -31220,
        -30600,
        -28800,
    ],
    is_dst=[
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-28800,
    posix_dst_offset=-28800,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
