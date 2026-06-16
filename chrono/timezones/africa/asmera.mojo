# Africa/Asmera — generated from IANA tzdata (2026b)
# 5 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime ASMERA = Timezone[5, 5](
    name="Africa/Asmera",
    area="Africa",
    location="Asmera",
    continent=Continent.AFRICA,
    transitions=[
        -1946168836,
        -1309746600,
        -1261969200,
        -1041388200,
        -865305900,
    ],
    type_indices=[
        1,
        2,
        1,
        3,
        2,
    ],
    offsets=[
        8836,
        9000,
        10800,
        9900,
        10800,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=10800,
    posix_dst_offset=10800,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
