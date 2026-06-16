# Suriname — ISO 3166-1 alpha-2 "SR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.paramaribo import PARAMARIBO


struct Suriname(ImplicitlyCopyable, Movable):
    """Suriname — ISO 3166-1 alpha-2 'SR'."""

    comptime CODE = StaticString("SR")
    comptime NAME = StaticString("Suriname")
    comptime FLAG = StaticString("🇸🇷")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 5]]:
        return (PARAMARIBO,)
