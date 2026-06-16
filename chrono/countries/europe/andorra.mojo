# Andorra — ISO 3166-1 alpha-2 "AD". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.andorra import ANDORRA


struct Andorra(ImplicitlyCopyable, Movable):
    """Andorra — ISO 3166-1 alpha-2 'AD'."""

    comptime CODE = StaticString("AD")
    comptime NAME = StaticString("Andorra")
    comptime FLAG = StaticString("🇦🇩")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("ca_AD")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[108, 5]]:
        return (ANDORRA,)
