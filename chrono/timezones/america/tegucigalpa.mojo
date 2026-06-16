# America/Tegucigalpa — generated from IANA tzdata (2026b)
# 7 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime TEGUCIGALPA = Timezone[7, 3](
    name="America/Tegucigalpa",
    area="America",
    location="Tegucigalpa",
    continent=Continent.AMERICAS,
    transitions=[
        -1538503868,
        547020000,
        559717200,
        578469600,
        591166800,
        1146981600,
        1154926800,
    ],
    type_indices=[
        2,
        1,
        2,
        1,
        2,
        1,
        2,
    ],
    offsets=[
        -20932,
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
