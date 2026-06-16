# Senegal — ISO 3166-1 alpha-2 "SN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.abidjan import ABIDJAN


struct Senegal(ImplicitlyCopyable, Movable):
    """Senegal — ISO 3166-1 alpha-2 'SN'."""

    comptime CODE = StaticString("SN")
    comptime NAME = StaticString("Senegal")
    comptime FLAG = StaticString("🇸🇳")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ff_SN|wo_SN")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (ABIDJAN,)
