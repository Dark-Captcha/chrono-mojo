# Kyrgyzstan — ISO 3166-1 alpha-2 "KG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.bishkek import BISHKEK


struct Kyrgyzstan(ImplicitlyCopyable, Movable):
    """Kyrgyzstan — ISO 3166-1 alpha-2 'KG'."""

    comptime CODE = StaticString("KG")
    comptime NAME = StaticString("Kyrgyzstan")
    comptime FLAG = StaticString("🇰🇬")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ky_KG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[52, 8]]:
        return (BISHKEK,)
