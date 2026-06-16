# Tajikistan — ISO 3166-1 alpha-2 "TJ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.dushanbe import DUSHANBE


struct Tajikistan(ImplicitlyCopyable, Movable):
    """Tajikistan — ISO 3166-1 alpha-2 'TJ'."""

    comptime CODE = StaticString("TJ")
    comptime NAME = StaticString("Tajikistan")
    comptime FLAG = StaticString("🇹🇯")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("tg_TJ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[24, 8]]:
        return (DUSHANBE,)
