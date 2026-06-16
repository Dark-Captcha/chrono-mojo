# United Arab Emirates — ISO 3166-1 alpha-2 "AE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.dubai import DUBAI


struct UnitedArabEmirates(ImplicitlyCopyable, Movable):
    """United Arab Emirates — ISO 3166-1 alpha-2 'AE'."""

    comptime CODE = StaticString("AE")
    comptime NAME = StaticString("United Arab Emirates")
    comptime FLAG = StaticString("🇦🇪")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_AE")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (DUBAI,)
