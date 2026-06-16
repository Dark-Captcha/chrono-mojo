# Oman — ISO 3166-1 alpha-2 "OM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.dubai import DUBAI


struct Oman(ImplicitlyCopyable, Movable):
    """Oman — ISO 3166-1 alpha-2 'OM'."""

    comptime CODE = StaticString("OM")
    comptime NAME = StaticString("Oman")
    comptime FLAG = StaticString("🇴🇲")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_OM")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (DUBAI,)
