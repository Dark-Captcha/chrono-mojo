# Pacific/Noumea — generated from IANA tzdata (2026b)
# 7 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime NOUMEA = Timezone[7, 5](
    name="Pacific/Noumea",
    area="Pacific",
    location="Noumea",
    continent=Continent.OCEANIA,
    transitions=[
        -1829387148,
        250002000,
        257342400,
        281451600,
        288878400,
        849366000,
        857228400,
    ],
    type_indices=[
        2,
        1,
        2,
        1,
        2,
        3,
        4,
    ],
    offsets=[
        39948,
        43200,
        39600,
        43200,
        39600,
    ],
    is_dst=[
        0,
        1,
        0,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=39600,
    posix_dst_offset=39600,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
