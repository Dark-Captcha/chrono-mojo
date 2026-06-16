# Ecuador — ISO 3166-1 alpha-2 "EC". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.guayaquil import GUAYAQUIL
from chrono.timezones.pacific.galapagos import GALAPAGOS


struct Ecuador(ImplicitlyCopyable, Movable):
    """Ecuador — ISO 3166-1 alpha-2 'EC'."""

    comptime CODE = StaticString("EC")
    comptime NAME = StaticString("Ecuador")
    comptime FLAG = StaticString("🇪🇨")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_EC")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4], Timezone[4, 4]]:
        return (GUAYAQUIL, GALAPAGOS)
