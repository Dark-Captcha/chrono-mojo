# Northern Mariana Islands — ISO 3166-1 alpha-2 "MP". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.guam import GUAM


struct NorthernMarianaIslands(ImplicitlyCopyable, Movable):
    """Northern Mariana Islands — ISO 3166-1 alpha-2 'MP'."""

    comptime CODE = StaticString("MP")
    comptime NAME = StaticString("Northern Mariana Islands")
    comptime FLAG = StaticString("🇲🇵")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[21, 6]]:
        return (GUAM,)
