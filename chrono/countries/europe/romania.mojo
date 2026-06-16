# Romania — ISO 3166-1 alpha-2 "RO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.bucharest import BUCHAREST


struct Romania(ImplicitlyCopyable, Movable):
    """Romania — ISO 3166-1 alpha-2 'RO'."""

    comptime CODE = StaticString("RO")
    comptime NAME = StaticString("Romania")
    comptime FLAG = StaticString("🇷🇴")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("ro_RO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[136, 8]]:
        return (BUCHAREST,)
