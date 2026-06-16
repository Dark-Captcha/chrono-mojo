# Saudi Arabia — ISO 3166-1 alpha-2 "SA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.riyadh import RIYADH


struct SaudiArabia(ImplicitlyCopyable, Movable):
    """Saudi Arabia — ISO 3166-1 alpha-2 'SA'."""

    comptime CODE = StaticString("SA")
    comptime NAME = StaticString("Saudi Arabia")
    comptime FLAG = StaticString("🇸🇦")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_SA")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (RIYADH,)
