# Libya — ISO 3166-1 alpha-2 "LY". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.tripoli import TRIPOLI


struct Libya(ImplicitlyCopyable, Movable):
    """Libya — ISO 3166-1 alpha-2 'LY'."""

    comptime CODE = StaticString("LY")
    comptime NAME = StaticString("Libya")
    comptime FLAG = StaticString("🇱🇾")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ar_LY")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[32, 4]]:
        return (TRIPOLI,)
