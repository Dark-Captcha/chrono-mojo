# Monaco — ISO 3166-1 alpha-2 "MC". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.paris import PARIS


struct Monaco(ImplicitlyCopyable, Movable):
    """Monaco — ISO 3166-1 alpha-2 'MC'."""

    comptime CODE = StaticString("MC")
    comptime NAME = StaticString("Monaco")
    comptime FLAG = StaticString("🇲🇨")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[184, 13]]:
        return (PARIS,)
