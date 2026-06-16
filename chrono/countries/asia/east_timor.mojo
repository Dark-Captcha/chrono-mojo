# East Timor — ISO 3166-1 alpha-2 "TL". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.dili import DILI


struct EastTimor(ImplicitlyCopyable, Movable):
    """East Timor — ISO 3166-1 alpha-2 'TL'."""

    comptime CODE = StaticString("TL")
    comptime NAME = StaticString("East Timor")
    comptime FLAG = StaticString("🇹🇱")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 5]]:
        return (DILI,)
