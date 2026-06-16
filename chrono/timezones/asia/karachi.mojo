# Asia/Karachi — generated from IANA tzdata (2026b)
# 11 historical transitions, 6 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime KARACHI = Timezone[11, 6](
    name="Asia/Karachi",
    area="Asia",
    location="Karachi",
    continent=Continent.ASIA,
    transitions=[
        -1988166492,
        -862637400,
        -764145000,
        -576135000,
        38775600,
        1018119600,
        1033840800,
        1212260400,
        1225476000,
        1239735600,
        1257012000,
    ],
    type_indices=[
        1,
        2,
        1,
        3,
        5,
        4,
        5,
        4,
        5,
        4,
        5,
    ],
    offsets=[
        16092,
        19800,
        23400,
        18000,
        21600,
        18000,
    ],
    is_dst=[
        0,
        0,
        1,
        0,
        1,
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
