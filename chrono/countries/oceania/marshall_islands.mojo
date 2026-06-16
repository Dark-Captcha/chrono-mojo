# Marshall Islands — ISO 3166-1 alpha-2 "MH". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.tarawa import TARAWA
from chrono.timezones.pacific.kwajalein import KWAJALEIN


struct MarshallIslands(ImplicitlyCopyable, Movable):
    """Marshall Islands — ISO 3166-1 alpha-2 'MH'."""

    comptime CODE = StaticString("MH")
    comptime NAME = StaticString("Marshall Islands")
    comptime FLAG = StaticString("🇲🇭")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2], Timezone[6, 6]]:
        return (TARAWA, KWAJALEIN)
