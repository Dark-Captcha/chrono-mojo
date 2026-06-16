# Namibia — ISO 3166-1 alpha-2 "NA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.windhoek import WINDHOEK


struct Namibia(ImplicitlyCopyable, Movable):
    """Namibia — ISO 3166-1 alpha-2 'NA'."""

    comptime CODE = StaticString("NA")
    comptime NAME = StaticString("Namibia")
    comptime FLAG = StaticString("🇳🇦")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[53, 6]]:
        return (WINDHOEK,)
