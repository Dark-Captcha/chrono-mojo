# America/Lima — generated from IANA tzdata (2026b)
# 16 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime LIMA = Timezone[16, 4](
    name="America/Lima",
    area="America",
    location="Lima",
    continent=Continent.AMERICAS,
    transitions=[
        -2524503108,
        -1938538284,
        -1009825200,
        -1002052800,
        -986756400,
        -971035200,
        -955306800,
        -939585600,
        504939600,
        512712000,
        536475600,
        544248000,
        631170000,
        638942400,
        757400400,
        765172800,
    ],
    type_indices=[
        1,
        3,
        2,
        3,
        2,
        3,
        2,
        3,
        2,
        3,
        2,
        3,
        2,
        3,
        2,
        3,
    ],
    offsets=[
        -18492,
        -18516,
        -14400,
        -18000,
    ],
    is_dst=[
        0,
        0,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-18000,
    posix_dst_offset=-18000,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
