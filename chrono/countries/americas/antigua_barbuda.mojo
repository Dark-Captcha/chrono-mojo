# Antigua & Barbuda — ISO 3166-1 alpha-2 "AG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct AntiguaBarbuda(ImplicitlyCopyable, Movable):
    """Antigua & Barbuda — ISO 3166-1 alpha-2 'AG'."""

    comptime CODE = StaticString("AG")
    comptime NAME = StaticString("Antigua & Barbuda")
    comptime FLAG = StaticString("🇦🇬")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("en_AG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
