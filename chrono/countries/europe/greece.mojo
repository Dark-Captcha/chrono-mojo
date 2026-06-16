# Greece — ISO 3166-1 alpha-2 "GR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.athens import ATHENS


struct Greece(ImplicitlyCopyable, Movable):
    """Greece — ISO 3166-1 alpha-2 'GR'."""

    comptime CODE = StaticString("GR")
    comptime NAME = StaticString("Greece")
    comptime FLAG = StaticString("🇬🇷")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("el_GR|el_GR@euro")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[138, 10]]:
        return (ATHENS,)
