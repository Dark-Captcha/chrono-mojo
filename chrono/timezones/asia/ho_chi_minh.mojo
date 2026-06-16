# Asia/Ho_Chi_Minh — generated from IANA tzdata (2026b)
# 9 historical transitions, 6 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime HO_CHI_MINH = Timezone[9, 6](
    name="Asia/Ho_Chi_Minh",
    area="Asia",
    location="Ho_Chi_Minh",
    continent=Continent.ASIA,
    transitions=[
        -2004073590,
        -1851577590,
        -852105600,
        -782643600,
        -767869200,
        -718095600,
        -457772400,
        -315648000,
        171820800,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
        2,
        3,
        2,
        3,
        2,
    ],
    offsets=[
        25590,
        25590,
        25200,
        28800,
        32400,
        25200,
    ],
    is_dst=[
        0,
        0,
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
