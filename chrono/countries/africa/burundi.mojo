# Burundi — ISO 3166-1 alpha-2 "BI". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.maputo import MAPUTO


struct Burundi(ImplicitlyCopyable, Movable):
    """Burundi — ISO 3166-1 alpha-2 'BI'."""

    comptime CODE = StaticString("BI")
    comptime NAME = StaticString("Burundi")
    comptime FLAG = StaticString("🇧🇮")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (MAPUTO,)
