# Pacific/Pago_Pago — generated from IANA tzdata (2026b)
# 2 historical transitions, 3 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime PAGO_PAGO = Timezone[2, 3](
    name="Pacific/Pago_Pago",
    area="Pacific",
    location="Pago_Pago",
    continent=Continent.OCEANIA,
    transitions=[
        -2445424632,
        -1861879032,
    ],
    type_indices=[
        1,
        2,
    ],
    offsets=[
        45432,
        -40968,
        -39600,
    ],
    is_dst=[
        0,
        0,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-39600,
    posix_dst_offset=-39600,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
