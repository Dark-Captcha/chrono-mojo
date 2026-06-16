# Solomon Islands — ISO 3166-1 alpha-2 "SB". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.guadalcanal import GUADALCANAL


struct SolomonIslands(ImplicitlyCopyable, Movable):
    """Solomon Islands — ISO 3166-1 alpha-2 'SB'."""

    comptime CODE = StaticString("SB")
    comptime NAME = StaticString("Solomon Islands")
    comptime FLAG = StaticString("🇸🇧")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (GUADALCANAL,)
