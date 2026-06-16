# Pacific/Tongatapu — generated from IANA tzdata (2026b)
# 10 historical transitions, 6 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime TONGATAPU = Timezone[10, 6](
    name="Pacific/Tongatapu",
    area="Pacific",
    location="Tongatapu",
    continent=Continent.OCEANIA,
    transitions=[
        -767189952,
        -284041200,
        939214800,
        953384400,
        973342800,
        980596800,
        1004792400,
        1012046400,
        1478350800,
        1484398800,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
        5,
        2,
        5,
        2,
        5,
        2,
    ],
    offsets=[
        44352,
        44400,
        46800,
        50400,
        46800,
        50400,
    ],
    is_dst=[
        0,
        0,
        0,
        1,
        0,
        1,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=46800,
    posix_dst_offset=46800,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
