# Guam — ISO 3166-1 alpha-2 "GU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.guam import GUAM


struct Guam(ImplicitlyCopyable, Movable):
    """Guam — ISO 3166-1 alpha-2 'GU'."""

    comptime CODE = StaticString("GU")
    comptime NAME = StaticString("Guam")
    comptime FLAG = StaticString("🇬🇺")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[21, 6]]:
        return (GUAM,)
