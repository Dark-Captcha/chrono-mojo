# Cook Islands — ISO 3166-1 alpha-2 "CK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.rarotonga import RAROTONGA


struct CookIslands(ImplicitlyCopyable, Movable):
    """Cook Islands — ISO 3166-1 alpha-2 'CK'."""

    comptime CODE = StaticString("CK")
    comptime NAME = StaticString("Cook Islands")
    comptime FLAG = StaticString("🇨🇰")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[28, 5]]:
        return (RAROTONGA,)
