# America/Paramaribo — generated from IANA tzdata (2026b)
# 4 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime PARAMARIBO = Timezone[4, 5](
    name="America/Paramaribo",
    area="America",
    location="Paramaribo",
    continent=Continent.AMERICAS,
    transitions=[
        -1861906760,
        -1104524348,
        -765317964,
        465449400,
    ],
    type_indices=[
        1,
        2,
        3,
        4,
    ],
    offsets=[
        -13240,
        -13252,
        -13236,
        -12600,
        -10800,
    ],
    is_dst=[
        0,
        0,
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-10800,
    posix_dst_offset=-10800,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
