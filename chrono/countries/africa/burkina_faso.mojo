# Burkina Faso — ISO 3166-1 alpha-2 "BF". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.abidjan import ABIDJAN


struct BurkinaFaso(ImplicitlyCopyable, Movable):
    """Burkina Faso — ISO 3166-1 alpha-2 'BF'."""

    comptime CODE = StaticString("BF")
    comptime NAME = StaticString("Burkina Faso")
    comptime FLAG = StaticString("🇧🇫")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (ABIDJAN,)
