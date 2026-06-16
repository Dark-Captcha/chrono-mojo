# Barbados — ISO 3166-1 alpha-2 "BB". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.barbados import BARBADOS


struct Barbados(ImplicitlyCopyable, Movable):
    """Barbados — ISO 3166-1 alpha-2 'BB'."""

    comptime CODE = StaticString("BB")
    comptime NAME = StaticString("Barbados")
    comptime FLAG = StaticString("🇧🇧")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[15, 6]]:
        return (BARBADOS,)
