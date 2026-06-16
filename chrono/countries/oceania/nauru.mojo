# Nauru — ISO 3166-1 alpha-2 "NR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.nauru import NAURU


struct Nauru(ImplicitlyCopyable, Movable):
    """Nauru — ISO 3166-1 alpha-2 'NR'."""

    comptime CODE = StaticString("NR")
    comptime NAME = StaticString("Nauru")
    comptime FLAG = StaticString("🇳🇷")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (NAURU,)
