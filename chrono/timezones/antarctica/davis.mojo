# Antarctica/Davis — generated from IANA tzdata (2026b)
# 7 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime DAVIS = Timezone[7, 4](
    name="Antarctica/Davis",
    area="Antarctica",
    location="Davis",
    continent=Continent.ANTARCTICA,
    transitions=[
        -409190400,
        -163062000,
        -28857600,
        1255806000,
        1268251200,
        1319742000,
        1329854400,
    ],
    type_indices=[
        1,
        0,
        1,
        2,
        3,
        2,
        3,
    ],
    offsets=[
        0,
        25200,
        18000,
        25200,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=25200,
    posix_dst_offset=25200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
