# Antarctica/Vostok — generated from IANA tzdata (2026b)
# 4 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime VOSTOK = Timezone[4, 3](
    name="Antarctica/Vostok",
    area="Antarctica",
    location="Vostok",
    continent=Continent.ANTARCTICA,
    transitions=[
        -380073600,
        760035600,
        783648000,
        1702839600,
    ],
    type_indices=[
        1,
        0,
        1,
        2,
    ],
    offsets=[
        0,
        25200,
        18000,
    ],
    is_dst=[
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=18000,
    posix_dst_offset=18000,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
