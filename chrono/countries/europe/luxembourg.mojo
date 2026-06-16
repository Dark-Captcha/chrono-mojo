# Luxembourg — ISO 3166-1 alpha-2 "LU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.brussels import BRUSSELS


struct Luxembourg(ImplicitlyCopyable, Movable):
    """Luxembourg — ISO 3166-1 alpha-2 'LU'."""

    comptime CODE = StaticString("LU")
    comptime NAME = StaticString("Luxembourg")
    comptime FLAG = StaticString("🇱🇺")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("de_LU|de_LU@euro|fr_LU|fr_LU@euro|lb_LU")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[185, 12]]:
        return (BRUSSELS,)
