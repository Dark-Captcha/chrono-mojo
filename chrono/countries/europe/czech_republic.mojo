# Czech Republic — ISO 3166-1 alpha-2 "CZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.prague import PRAGUE


struct CzechRepublic(ImplicitlyCopyable, Movable):
    """Czech Republic — ISO 3166-1 alpha-2 'CZ'."""

    comptime CODE = StaticString("CZ")
    comptime NAME = StaticString("Czech Republic")
    comptime FLAG = StaticString("🇨🇿")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("cs_CZ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[144, 9]]:
        return (PRAGUE,)
