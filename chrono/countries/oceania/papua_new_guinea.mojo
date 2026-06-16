# Papua New Guinea — ISO 3166-1 alpha-2 "PG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.port_moresby import PORT_MORESBY
from chrono.timezones.pacific.bougainville import BOUGAINVILLE


struct PapuaNewGuinea(ImplicitlyCopyable, Movable):
    """Papua New Guinea — ISO 3166-1 alpha-2 'PG'."""

    comptime CODE = StaticString("PG")
    comptime NAME = StaticString("Papua New Guinea")
    comptime FLAG = StaticString("🇵🇬")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("tpi_PG|yuw_PG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3], Timezone[5, 5]]:
        return (PORT_MORESBY, BOUGAINVILLE)
