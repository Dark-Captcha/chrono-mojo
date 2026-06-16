# Dominica — ISO 3166-1 alpha-2 "DM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct Dominica(ImplicitlyCopyable, Movable):
    """Dominica — ISO 3166-1 alpha-2 'DM'."""

    comptime CODE = StaticString("DM")
    comptime NAME = StaticString("Dominica")
    comptime FLAG = StaticString("🇩🇲")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
