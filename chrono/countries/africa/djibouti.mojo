# Djibouti — ISO 3166-1 alpha-2 "DJ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Djibouti(ImplicitlyCopyable, Movable):
    """Djibouti — ISO 3166-1 alpha-2 'DJ'."""

    comptime CODE = StaticString("DJ")
    comptime NAME = StaticString("Djibouti")
    comptime FLAG = StaticString("🇩🇯")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("aa_DJ|so_DJ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
