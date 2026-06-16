# Latvia — ISO 3166-1 alpha-2 "LV". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.riga import RIGA


struct Latvia(ImplicitlyCopyable, Movable):
    """Latvia — ISO 3166-1 alpha-2 'LV'."""

    comptime CODE = StaticString("LV")
    comptime NAME = StaticString("Latvia")
    comptime FLAG = StaticString("🇱🇻")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("ltg_LV|lv_LV")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[126, 15]]:
        return (RIGA,)
