# Serbia — ISO 3166-1 alpha-2 "RS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.belgrade import BELGRADE


struct Serbia(ImplicitlyCopyable, Movable):
    """Serbia — ISO 3166-1 alpha-2 'RS'."""

    comptime CODE = StaticString("RS")
    comptime NAME = StaticString("Serbia")
    comptime FLAG = StaticString("🇷🇸")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("sr_RS|sr_RS@latin")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[119, 7]]:
        return (BELGRADE,)
