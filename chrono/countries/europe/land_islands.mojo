# Åland Islands — ISO 3166-1 alpha-2 "AX". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.helsinki import HELSINKI


struct LandIslands(ImplicitlyCopyable, Movable):
    """Åland Islands — ISO 3166-1 alpha-2 'AX'."""

    comptime CODE = StaticString("AX")
    comptime NAME = StaticString("Åland Islands")
    comptime FLAG = StaticString("🇦🇽")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[118, 6]]:
        return (HELSINKI,)
