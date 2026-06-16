# Gibraltar — ISO 3166-1 alpha-2 "GI". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.gibraltar import GIBRALTAR


struct Gibraltar(ImplicitlyCopyable, Movable):
    """Gibraltar — ISO 3166-1 alpha-2 'GI'."""

    comptime CODE = StaticString("GI")
    comptime NAME = StaticString("Gibraltar")
    comptime FLAG = StaticString("🇬🇮")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[198, 8]]:
        return (GIBRALTAR,)
