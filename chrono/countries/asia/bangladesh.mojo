# Bangladesh — ISO 3166-1 alpha-2 "BD". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.dhaka import DHAKA


struct Bangladesh(ImplicitlyCopyable, Movable):
    """Bangladesh — ISO 3166-1 alpha-2 'BD'."""

    comptime CODE = StaticString("BD")
    comptime NAME = StaticString("Bangladesh")
    comptime FLAG = StaticString("🇧🇩")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("bn_BD")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[7, 6]]:
        return (DHAKA,)
