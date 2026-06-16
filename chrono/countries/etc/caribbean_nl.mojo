# Caribbean NL — ISO 3166-1 alpha-2 "BQ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct CaribbeanNl(ImplicitlyCopyable, Movable):
    """Caribbean NL — ISO 3166-1 alpha-2 'BQ'."""

    comptime CODE = StaticString("BQ")
    comptime NAME = StaticString("Caribbean NL")
    comptime FLAG = StaticString("🇧🇶")
    comptime CONTINENT = Continent.ETC
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
