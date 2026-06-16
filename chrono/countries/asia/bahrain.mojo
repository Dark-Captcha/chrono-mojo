# Bahrain — ISO 3166-1 alpha-2 "BH". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.qatar import QATAR


struct Bahrain(ImplicitlyCopyable, Movable):
    """Bahrain — ISO 3166-1 alpha-2 'BH'."""

    comptime CODE = StaticString("BH")
    comptime NAME = StaticString("Bahrain")
    comptime FLAG = StaticString("🇧🇭")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_BH")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (QATAR,)
