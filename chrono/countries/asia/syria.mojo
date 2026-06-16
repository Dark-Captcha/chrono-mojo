# Syria — ISO 3166-1 alpha-2 "SY". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.damascus import DAMASCUS


struct Syria(ImplicitlyCopyable, Movable):
    """Syria — ISO 3166-1 alpha-2 'SY'."""

    comptime CODE = StaticString("SY")
    comptime NAME = StaticString("Syria")
    comptime FLAG = StaticString("🇸🇾")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_SY")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[121, 4]]:
        return (DAMASCUS,)
