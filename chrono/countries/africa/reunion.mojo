# Réunion — ISO 3166-1 alpha-2 "RE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.dubai import DUBAI


struct Reunion(ImplicitlyCopyable, Movable):
    """Réunion — ISO 3166-1 alpha-2 'RE'."""

    comptime CODE = StaticString("RE")
    comptime NAME = StaticString("Réunion")
    comptime FLAG = StaticString("🇷🇪")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (DUBAI,)
