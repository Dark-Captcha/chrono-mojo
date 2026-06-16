# Yemen — ISO 3166-1 alpha-2 "YE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.riyadh import RIYADH


struct Yemen(ImplicitlyCopyable, Movable):
    """Yemen — ISO 3166-1 alpha-2 'YE'."""

    comptime CODE = StaticString("YE")
    comptime NAME = StaticString("Yemen")
    comptime FLAG = StaticString("🇾🇪")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_YE")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (RIYADH,)
