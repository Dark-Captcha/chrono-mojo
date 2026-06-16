# Thailand — ISO 3166-1 alpha-2 "TH". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.bangkok import BANGKOK


struct Thailand(ImplicitlyCopyable, Movable):
    """Thailand — ISO 3166-1 alpha-2 'TH'."""

    comptime CODE = StaticString("TH")
    comptime NAME = StaticString("Thailand")
    comptime FLAG = StaticString("🇹🇭")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("th_TH")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (BANGKOK,)
