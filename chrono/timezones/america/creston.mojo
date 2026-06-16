# America/Creston — generated from IANA tzdata (2026b)
# 11 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime CRESTON = Timezone[11, 5](
    name="America/Creston",
    area="America",
    location="Creston",
    continent=Continent.AMERICAS,
    transitions=[
        -2717643600,
        -1633273200,
        -1615132800,
        -1601823600,
        -1583683200,
        -880210800,
        -820519140,
        -812653140,
        -796845540,
        -84380400,
        -68659200,
    ],
    type_indices=[
        4,
        1,
        2,
        1,
        2,
        3,
        2,
        3,
        2,
        1,
        2,
    ],
    offsets=[
        -26898,
        -21600,
        -25200,
        -21600,
        -25200,
    ],
    is_dst=[
        0,
        1,
        0,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-25200,
    posix_dst_offset=-25200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
