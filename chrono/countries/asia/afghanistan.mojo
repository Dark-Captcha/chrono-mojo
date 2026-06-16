# Afghanistan — ISO 3166-1 alpha-2 "AF". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.kabul import KABUL


struct Afghanistan(ImplicitlyCopyable, Movable):
    """Afghanistan — ISO 3166-1 alpha-2 'AF'."""

    comptime CODE = StaticString("AF")
    comptime NAME = StaticString("Afghanistan")
    comptime FLAG = StaticString("🇦🇫")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ps_AF")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (KABUL,)
