# Sri Lanka — ISO 3166-1 alpha-2 "LK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.colombo import COLOMBO


struct SriLanka(ImplicitlyCopyable, Movable):
    """Sri Lanka — ISO 3166-1 alpha-2 'LK'."""

    comptime CODE = StaticString("LK")
    comptime NAME = StaticString("Sri Lanka")
    comptime FLAG = StaticString("🇱🇰")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("si_LK|ta_LK")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[8, 8]]:
        return (COLOMBO,)
