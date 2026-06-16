# Australia/Queensland — generated from IANA tzdata (2026b)
# 17 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime QUEENSLAND = Timezone[17, 4](
    name="Australia/Queensland",
    area="Australia",
    location="Queensland",
    continent=Continent.OCEANIA,
    transitions=[
        -2366791928,
        -1672560000,
        -1665388800,
        -883641600,
        -876124800,
        -860400000,
        -844675200,
        -828345600,
        -813225600,
        57686400,
        67968000,
        625593600,
        636480000,
        657043200,
        667929600,
        688492800,
        699379200,
    ],
    type_indices=[
        3,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
    ],
    offsets=[
        36728,
        39600,
        36000,
        36000,
    ],
    is_dst=[
        0,
        1,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=36000,
    posix_dst_offset=36000,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
