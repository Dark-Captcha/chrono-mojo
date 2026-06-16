# America/Managua — generated from IANA tzdata (2026b)
# 16 historical transitions, 6 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime MANAGUA = Timezone[16, 6](
    name="America/Managua",
    area="America",
    location="Managua",
    continent=Continent.AMERICAS,
    transitions=[
        -2524500892,
        -1121105688,
        105084000,
        161758800,
        290584800,
        299134800,
        322034400,
        330584400,
        694260000,
        717310800,
        725868000,
        852094800,
        1113112800,
        1128229200,
        1146384000,
        1159682400,
    ],
    type_indices=[
        1,
        2,
        3,
        2,
        4,
        2,
        4,
        2,
        3,
        2,
        3,
        2,
        4,
        2,
        4,
        2,
    ],
    offsets=[
        -20708,
        -20712,
        -21600,
        -18000,
        -18000,
        -21600,
    ],
    is_dst=[
        0,
        0,
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
