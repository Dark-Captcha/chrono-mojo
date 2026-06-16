# Puerto Rico — ISO 3166-1 alpha-2 "PR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct PuertoRico(ImplicitlyCopyable, Movable):
    """Puerto Rico — ISO 3166-1 alpha-2 'PR'."""

    comptime CODE = StaticString("PR")
    comptime NAME = StaticString("Puerto Rico")
    comptime FLAG = StaticString("🇵🇷")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_PR")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
