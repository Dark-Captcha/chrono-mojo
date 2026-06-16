# Azerbaijan — ISO 3166-1 alpha-2 "AZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.baku import BAKU


struct Azerbaijan(ImplicitlyCopyable, Movable):
    """Azerbaijan — ISO 3166-1 alpha-2 'AZ'."""

    comptime CODE = StaticString("AZ")
    comptime NAME = StaticString("Azerbaijan")
    comptime FLAG = StaticString("🇦🇿")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("az_AZ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[66, 10]]:
        return (BAKU,)
