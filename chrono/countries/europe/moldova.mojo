# Moldova — ISO 3166-1 alpha-2 "MD". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.chisinau import CHISINAU


struct Moldova(ImplicitlyCopyable, Movable):
    """Moldova — ISO 3166-1 alpha-2 'MD'."""

    comptime CODE = StaticString("MD")
    comptime NAME = StaticString("Moldova")
    comptime FLAG = StaticString("🇲🇩")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[141, 16]]:
        return (CHISINAU,)
