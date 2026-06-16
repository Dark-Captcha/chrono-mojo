# Albania — ISO 3166-1 alpha-2 "AL". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.tirane import TIRANE


struct Albania(ImplicitlyCopyable, Movable):
    """Albania — ISO 3166-1 alpha-2 'AL'."""

    comptime CODE = StaticString("AL")
    comptime NAME = StaticString("Albania")
    comptime FLAG = StaticString("🇦🇱")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("sq_AL")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[133, 5]]:
        return (TIRANE,)
