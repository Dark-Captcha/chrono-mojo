# Dominican Republic — ISO 3166-1 alpha-2 "DO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.santo_domingo import SANTO_DOMINGO


struct DominicanRepublic(ImplicitlyCopyable, Movable):
    """Dominican Republic — ISO 3166-1 alpha-2 'DO'."""

    comptime CODE = StaticString("DO")
    comptime NAME = StaticString("Dominican Republic")
    comptime FLAG = StaticString("🇩🇴")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_DO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[17, 6]]:
        return (SANTO_DOMINGO,)
