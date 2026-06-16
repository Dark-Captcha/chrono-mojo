# Cocos (Keeling) Islands — ISO 3166-1 alpha-2 "CC". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.yangon import YANGON


struct CocosKeelingIslands(ImplicitlyCopyable, Movable):
    """Cocos (Keeling) Islands — ISO 3166-1 alpha-2 'CC'."""

    comptime CODE = StaticString("CC")
    comptime NAME = StaticString("Cocos (Keeling) Islands")
    comptime FLAG = StaticString("🇨🇨")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 5]]:
        return (YANGON,)
