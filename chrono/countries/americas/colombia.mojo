# Colombia — ISO 3166-1 alpha-2 "CO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.bogota import BOGOTA


struct Colombia(ImplicitlyCopyable, Movable):
    """Colombia — ISO 3166-1 alpha-2 'CO'."""

    comptime CODE = StaticString("CO")
    comptime NAME = StaticString("Colombia")
    comptime FLAG = StaticString("🇨🇴")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_CO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (BOGOTA,)
