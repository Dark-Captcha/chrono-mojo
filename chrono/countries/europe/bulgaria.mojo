# Bulgaria — ISO 3166-1 alpha-2 "BG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.sofia import SOFIA


struct Bulgaria(ImplicitlyCopyable, Movable):
    """Bulgaria — ISO 3166-1 alpha-2 'BG'."""

    comptime CODE = StaticString("BG")
    comptime NAME = StaticString("Bulgaria")
    comptime FLAG = StaticString("🇧🇬")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("bg_BG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[126, 10]]:
        return (SOFIA,)
