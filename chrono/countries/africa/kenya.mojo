# Kenya — ISO 3166-1 alpha-2 "KE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Kenya(ImplicitlyCopyable, Movable):
    """Kenya — ISO 3166-1 alpha-2 'KE'."""

    comptime CODE = StaticString("KE")
    comptime NAME = StaticString("Kenya")
    comptime FLAG = StaticString("🇰🇪")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("om_KE|so_KE|sw_KE")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
