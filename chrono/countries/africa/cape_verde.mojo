# Cape Verde — ISO 3166-1 alpha-2 "CV". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.atlantic.cape_verde import CAPE_VERDE


struct CapeVerde(ImplicitlyCopyable, Movable):
    """Cape Verde — ISO 3166-1 alpha-2 'CV'."""

    comptime CODE = StaticString("CV")
    comptime NAME = StaticString("Cape Verde")
    comptime FLAG = StaticString("🇨🇻")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 5]]:
        return (CAPE_VERDE,)
