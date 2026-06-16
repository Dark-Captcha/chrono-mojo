# French Guiana — ISO 3166-1 alpha-2 "GF". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.cayenne import CAYENNE


struct FrenchGuiana(ImplicitlyCopyable, Movable):
    """French Guiana — ISO 3166-1 alpha-2 'GF'."""

    comptime CODE = StaticString("GF")
    comptime NAME = StaticString("French Guiana")
    comptime FLAG = StaticString("🇬🇫")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (CAYENNE,)
