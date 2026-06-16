# Iran — ISO 3166-1 alpha-2 "IR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.tehran import TEHRAN


struct Iran(ImplicitlyCopyable, Movable):
    """Iran — ISO 3166-1 alpha-2 'IR'."""

    comptime CODE = StaticString("IR")
    comptime NAME = StaticString("Iran")
    comptime FLAG = StaticString("🇮🇷")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("az_IR|fa_IR")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[71, 8]]:
        return (TEHRAN,)
