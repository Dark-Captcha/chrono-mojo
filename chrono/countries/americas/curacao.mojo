# Curaçao — ISO 3166-1 alpha-2 "CW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct Curacao(ImplicitlyCopyable, Movable):
    """Curaçao — ISO 3166-1 alpha-2 'CW'."""

    comptime CODE = StaticString("CW")
    comptime NAME = StaticString("Curaçao")
    comptime FLAG = StaticString("🇨🇼")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("pap_CW")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
