# Botswana — ISO 3166-1 alpha-2 "BW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.maputo import MAPUTO


struct Botswana(ImplicitlyCopyable, Movable):
    """Botswana — ISO 3166-1 alpha-2 'BW'."""

    comptime CODE = StaticString("BW")
    comptime NAME = StaticString("Botswana")
    comptime FLAG = StaticString("🇧🇼")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("en_BW")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (MAPUTO,)
