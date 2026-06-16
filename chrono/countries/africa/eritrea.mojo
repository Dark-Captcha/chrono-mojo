# Eritrea — ISO 3166-1 alpha-2 "ER". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Eritrea(ImplicitlyCopyable, Movable):
    """Eritrea — ISO 3166-1 alpha-2 'ER'."""

    comptime CODE = StaticString("ER")
    comptime NAME = StaticString("Eritrea")
    comptime FLAG = StaticString("🇪🇷")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString(
        "aa_ER|byn_ER|gez_ER|gez_ER@abegede|ssy_ER|ti_ER|tig_ER"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
