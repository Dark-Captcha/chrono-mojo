# America/Guatemala — generated from IANA tzdata (2026b)
# 9 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime GUATEMALA = Timezone[9, 3](
    name="America/Guatemala",
    area="America",
    location="Guatemala",
    continent=Continent.AMERICAS,
    transitions=[
        -1617040676,
        123055200,
        130914000,
        422344800,
        433054800,
        669708000,
        684219600,
        1146376800,
        1159678800,
    ],
    type_indices=[
        2,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        2,
    ],
    offsets=[
        -21724,
        -18000,
        -21600,
    ],
    is_dst=[
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
