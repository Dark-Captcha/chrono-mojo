# Guyana — ISO 3166-1 alpha-2 "GY". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.guyana import GUYANA


struct Guyana(ImplicitlyCopyable, Movable):
    """Guyana — ISO 3166-1 alpha-2 'GY'."""

    comptime CODE = StaticString("GY")
    comptime NAME = StaticString("Guyana")
    comptime FLAG = StaticString("🇬🇾")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 5]]:
        return (GUYANA,)
