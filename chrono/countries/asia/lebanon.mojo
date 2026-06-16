# Lebanon — ISO 3166-1 alpha-2 "LB". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.beirut import BEIRUT


struct Lebanon(ImplicitlyCopyable, Movable):
    """Lebanon — ISO 3166-1 alpha-2 'LB'."""

    comptime CODE = StaticString("LB")
    comptime NAME = StaticString("Lebanon")
    comptime FLAG = StaticString("🇱🇧")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_LB")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[141, 3]]:
        return (BEIRUT,)
