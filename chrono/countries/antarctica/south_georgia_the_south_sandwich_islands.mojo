# South Georgia & the South Sandwich Islands — ISO 3166-1 alpha-2 "GS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.atlantic.south_georgia import SOUTH_GEORGIA


struct SouthGeorgiaTheSouthSandwichIslands(ImplicitlyCopyable, Movable):
    """South Georgia & the South Sandwich Islands — ISO 3166-1 alpha-2 'GS'."""

    comptime CODE = StaticString("GS")
    comptime NAME = StaticString("South Georgia & the South Sandwich Islands")
    comptime FLAG = StaticString("🇬🇸")
    comptime CONTINENT = Continent.ANTARCTICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (SOUTH_GEORGIA,)
