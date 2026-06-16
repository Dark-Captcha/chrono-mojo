# Costa Rica — ISO 3166-1 alpha-2 "CR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.costa_rica import COSTA_RICA


struct CostaRica(ImplicitlyCopyable, Movable):
    """Costa Rica — ISO 3166-1 alpha-2 'CR'."""

    comptime CODE = StaticString("CR")
    comptime NAME = StaticString("Costa Rica")
    comptime FLAG = StaticString("🇨🇷")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_CR")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[10, 4]]:
        return (COSTA_RICA,)
