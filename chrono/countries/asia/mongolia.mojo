# Mongolia — ISO 3166-1 alpha-2 "MN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.ulaanbaatar import ULAANBAATAR
from chrono.timezones.asia.hovd import HOVD


struct Mongolia(ImplicitlyCopyable, Movable):
    """Mongolia — ISO 3166-1 alpha-2 'MN'."""

    comptime CODE = StaticString("MN")
    comptime NAME = StaticString("Mongolia")
    comptime FLAG = StaticString("🇲🇳")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("mn_MN")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[50, 4], Timezone[50, 4]]:
        return (ULAANBAATAR, HOVD)
