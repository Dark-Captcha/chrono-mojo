# Ukraine — ISO 3166-1 alpha-2 "UA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.simferopol import SIMFEROPOL
from chrono.timezones.europe.kyiv import KYIV


struct Ukraine(ImplicitlyCopyable, Movable):
    """Ukraine — ISO 3166-1 alpha-2 'UA'."""

    comptime CODE = StaticString("UA")
    comptime NAME = StaticString("Ukraine")
    comptime FLAG = StaticString("🇺🇦")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("crh_UA|ru_UA|uk_UA")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[75, 16], Timezone[121, 15]]:
        return (SIMFEROPOL, KYIV)
