# China — ISO 3166-1 alpha-2 "CN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.shanghai import SHANGHAI
from chrono.timezones.asia.urumqi import URUMQI


struct China(ImplicitlyCopyable, Movable):
    """China — ISO 3166-1 alpha-2 'CN'."""

    comptime CODE = StaticString("CN")
    comptime NAME = StaticString("China")
    comptime FLAG = StaticString("🇨🇳")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("bo_CN|ug_CN|zh_CN")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[29, 3], Timezone[1, 2]]:
        return (SHANGHAI, URUMQI)
