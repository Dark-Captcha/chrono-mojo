# Cuba — ISO 3166-1 alpha-2 "CU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.havana import HAVANA


struct Cuba(ImplicitlyCopyable, Movable):
    """Cuba — ISO 3166-1 alpha-2 'CU'."""

    comptime CODE = StaticString("CU")
    comptime NAME = StaticString("Cuba")
    comptime FLAG = StaticString("🇨🇺")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_CU")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[156, 6]]:
        return (HAVANA,)
