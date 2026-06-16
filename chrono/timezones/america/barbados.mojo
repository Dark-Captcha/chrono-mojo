# America/Barbados — generated from IANA tzdata (2026b)
# 15 historical transitions, 6 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime BARBADOS = Timezone[15, 6](
    name="America/Barbados",
    area="America",
    location="Barbados",
    continent=Continent.AMERICAS,
    transitions=[
        -1841256091,
        -874263600,
        -862682400,
        -841604400,
        -830714400,
        -811882800,
        -798660000,
        234943200,
        244616400,
        261554400,
        276066000,
        293004000,
        307515600,
        325058400,
        338706000,
    ],
    type_indices=[
        3,
        1,
        2,
        1,
        2,
        4,
        2,
        5,
        3,
        5,
        3,
        5,
        3,
        5,
        3,
    ],
    offsets=[
        -14309,
        -10800,
        -14400,
        -14400,
        -12600,
        -10800,
    ],
    is_dst=[
        0,
        1,
        0,
        0,
        1,
        1,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-14400,
    posix_dst_offset=-14400,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
