# Austria — ISO 3166-1 alpha-2 "AT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.vienna import VIENNA


struct Austria(ImplicitlyCopyable, Movable):
    """Austria — ISO 3166-1 alpha-2 'AT'."""

    comptime CODE = StaticString("AT")
    comptime NAME = StaticString("Austria")
    comptime FLAG = StaticString("🇦🇹")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("de_AT|de_AT@euro")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[139, 7]]:
        return (VIENNA,)
