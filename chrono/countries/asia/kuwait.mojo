# Kuwait — ISO 3166-1 alpha-2 "KW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.riyadh import RIYADH


struct Kuwait(ImplicitlyCopyable, Movable):
    """Kuwait — ISO 3166-1 alpha-2 'KW'."""

    comptime CODE = StaticString("KW")
    comptime NAME = StaticString("Kuwait")
    comptime FLAG = StaticString("🇰🇼")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_KW")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (RIYADH,)
