# Poland — ISO 3166-1 alpha-2 "PL". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.warsaw import WARSAW


struct Poland(ImplicitlyCopyable, Movable):
    """Poland — ISO 3166-1 alpha-2 'PL'."""

    comptime CODE = StaticString("PL")
    comptime NAME = StaticString("Poland")
    comptime FLAG = StaticString("🇵🇱")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("csb_PL|pl_PL|szl_PL")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[165, 11]]:
        return (WARSAW,)
