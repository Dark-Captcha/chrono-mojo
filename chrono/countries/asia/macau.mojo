# Macau — ISO 3166-1 alpha-2 "MO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.macau import MACAU


struct Macau(ImplicitlyCopyable, Movable):
    """Macau — ISO 3166-1 alpha-2 'MO'."""

    comptime CODE = StaticString("MO")
    comptime NAME = StaticString("Macau")
    comptime FLAG = StaticString("🇲🇴")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[71, 7]]:
        return (MACAU,)
