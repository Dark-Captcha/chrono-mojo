# America/Hermosillo — generated from IANA tzdata (2026b)
# 13 historical transitions, 5 distinct offset types. Comptime-baked: zero
# runtime I/O, zero parse cost. Edit by hand if a name/comment needs refinement;
# transition data should be regenerated when tzdata updates.

from chrono.timezone import Timezone
from chrono.continent import Continent


comptime HERMOSILLO = Timezone[13, 5](
    name="America/Hermosillo",
    area="America",
    location="Hermosillo",
    continent=Continent.AMERICAS,
    transitions=[
        -1514739600,
        -1343149200,
        -1234807200,
        -1220461200,
        -1207159200,
        -1191344400,
        -873828000,
        828867600,
        846403200,
        860317200,
        877852800,
        891766800,
        909302400,
    ],
    type_indices=[
        1,
        2,
        4,
        3,
        4,
        2,
        4,
        3,
        4,
        3,
        4,
        3,
        4,
    ],
    offsets=[
        -26632,
        -25200,
        -21600,
        -21600,
        -25200,
    ],
    is_dst=[
        0,
        0,
        0,
        1,
        0,
    ],
    posix_has_rule=True,
    posix_has_dst=False,
    posix_std_offset=-25200,
    posix_dst_offset=-25200,
    posix_start_month=0,
    posix_start_week=0,
    posix_start_day=0,
    posix_start_time=0,
    posix_end_month=0,
    posix_end_week=0,
    posix_end_day=0,
    posix_end_time=0,
)
