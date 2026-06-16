# Turkmenistan — ISO 3166-1 alpha-2 "TM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.ashgabat import ASHGABAT


struct Turkmenistan(ImplicitlyCopyable, Movable):
    """Turkmenistan — ISO 3166-1 alpha-2 'TM'."""

    comptime CODE = StaticString("TM")
    comptime NAME = StaticString("Turkmenistan")
    comptime FLAG = StaticString("🇹🇲")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("tk_TM")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[25, 9]]:
        return (ASHGABAT,)
