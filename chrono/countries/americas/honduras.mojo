# Honduras — ISO 3166-1 alpha-2 "HN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.tegucigalpa import TEGUCIGALPA


struct Honduras(ImplicitlyCopyable, Movable):
    """Honduras — ISO 3166-1 alpha-2 'HN'."""

    comptime CODE = StaticString("HN")
    comptime NAME = StaticString("Honduras")
    comptime FLAG = StaticString("🇭🇳")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_HN")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[7, 3]]:
        return (TEGUCIGALPA,)
