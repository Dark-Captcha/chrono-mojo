# British Indian Ocean Territory — ISO 3166-1 alpha-2 "IO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.indian.chagos import CHAGOS


struct BritishIndianOceanTerritory(ImplicitlyCopyable, Movable):
    """British Indian Ocean Territory — ISO 3166-1 alpha-2 'IO'."""

    comptime CODE = StaticString("IO")
    comptime NAME = StaticString("British Indian Ocean Territory")
    comptime FLAG = StaticString("🇮🇴")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (CHAGOS,)
