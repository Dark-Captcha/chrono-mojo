# Bahamas — ISO 3166-1 alpha-2 "BS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.toronto import TORONTO


struct Bahamas(ImplicitlyCopyable, Movable):
    """Bahamas — ISO 3166-1 alpha-2 'BS'."""

    comptime CODE = StaticString("BS")
    comptime NAME = StaticString("Bahamas")
    comptime FLAG = StaticString("🇧🇸")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[233, 5]]:
        return (TORONTO,)
