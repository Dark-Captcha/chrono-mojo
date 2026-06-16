# Etc/GMT-7 — generated from IANA tzdata (2026b)
# 0 historical transitions, 1 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime GMT_7 = Timezone[0, 1](
    name="Etc/GMT-7",
    area="Etc",
    location="GMT-7",
    continent=Continent.ETC,
    transitions=[],
    type_indices=[],
    offsets=[
        25200,
    ],
    is_dst=[
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
