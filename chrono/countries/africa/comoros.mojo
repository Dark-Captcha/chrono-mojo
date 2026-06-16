# Comoros — ISO 3166-1 alpha-2 "KM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Comoros(ImplicitlyCopyable, Movable):
    """Comoros — ISO 3166-1 alpha-2 'KM'."""

    comptime CODE = StaticString("KM")
    comptime NAME = StaticString("Comoros")
    comptime FLAG = StaticString("🇰🇲")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
