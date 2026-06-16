# Faroe Islands — ISO 3166-1 alpha-2 "FO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.atlantic.faroe import FAROE


struct FaroeIslands(ImplicitlyCopyable, Movable):
    """Faroe Islands — ISO 3166-1 alpha-2 'FO'."""

    comptime CODE = StaticString("FO")
    comptime NAME = StaticString("Faroe Islands")
    comptime FLAG = StaticString("🇫🇴")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("fo_FO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[115, 4]]:
        return (FAROE,)
