# America/Marigot — generated from IANA tzdata (2026b)
# 4 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime MARIGOT = Timezone[4, 4](
    name="America/Marigot",
    area="America",
    location="Marigot",
    continent=Continent.AMERICAS,
    transitions=[
        -2233035335,
        -873057600,
        -769395600,
        -765399600,
    ],
    type_indices=[
        1,
        3,
        2,
        1,
    ],
    offsets=[
        -15865,
        -14400,
        -10800,
        -10800,
    ],
    is_dst=[
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
