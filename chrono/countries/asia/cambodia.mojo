# Cambodia — ISO 3166-1 alpha-2 "KH". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.bangkok import BANGKOK


struct Cambodia(ImplicitlyCopyable, Movable):
    """Cambodia — ISO 3166-1 alpha-2 'KH'."""

    comptime CODE = StaticString("KH")
    comptime NAME = StaticString("Cambodia")
    comptime FLAG = StaticString("🇰🇭")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("km_KH")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (BANGKOK,)
