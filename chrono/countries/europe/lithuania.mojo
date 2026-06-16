# Lithuania — ISO 3166-1 alpha-2 "LT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.vilnius import VILNIUS


struct Lithuania(ImplicitlyCopyable, Movable):
    """Lithuania — ISO 3166-1 alpha-2 'LT'."""

    comptime CODE = StaticString("LT")
    comptime NAME = StaticString("Lithuania")
    comptime FLAG = StaticString("🇱🇹")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("lt_LT|sgs_LT")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[120, 18]]:
        return (VILNIUS,)
