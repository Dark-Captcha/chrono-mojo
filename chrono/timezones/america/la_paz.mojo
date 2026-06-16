# America/La_Paz — generated from IANA tzdata (2026b)
# 3 historical transitions, 4 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime LA_PAZ = Timezone[3, 4](
    name="America/La_Paz",
    area="America",
    location="La_Paz",
    continent=Continent.AMERICAS,
    transitions=[
        -2524505244,
        -1205954844,
        -1192307244,
    ],
    type_indices=[
        1,
        2,
        3,
    ],
    offsets=[
        -16356,
        -16356,
        -12756,
        -14400,
    ],
    is_dst=[
        0,
        0,
        1,
        0,
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
