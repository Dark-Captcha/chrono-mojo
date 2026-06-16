# Georgia — ISO 3166-1 alpha-2 "GE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.tbilisi import TBILISI


struct Georgia(ImplicitlyCopyable, Movable):
    """Georgia — ISO 3166-1 alpha-2 'GE'."""

    comptime CODE = StaticString("GE")
    comptime NAME = StaticString("Georgia")
    comptime FLAG = StaticString("🇬🇪")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ab_GE|ka_GE")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[51, 11]]:
        return (TBILISI,)
