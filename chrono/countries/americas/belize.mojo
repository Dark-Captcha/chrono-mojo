# Belize — ISO 3166-1 alpha-2 "BZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.belize import BELIZE


struct Belize(ImplicitlyCopyable, Movable):
    """Belize — ISO 3166-1 alpha-2 'BZ'."""

    comptime CODE = StaticString("BZ")
    comptime NAME = StaticString("Belize")
    comptime FLAG = StaticString("🇧🇿")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[98, 6]]:
        return (BELIZE,)
