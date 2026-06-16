# Martinique — ISO 3166-1 alpha-2 "MQ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.martinique import MARTINIQUE


struct Martinique(ImplicitlyCopyable, Movable):
    """Martinique — ISO 3166-1 alpha-2 'MQ'."""

    comptime CODE = StaticString("MQ")
    comptime NAME = StaticString("Martinique")
    comptime FLAG = StaticString("🇲🇶")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (MARTINIQUE,)
