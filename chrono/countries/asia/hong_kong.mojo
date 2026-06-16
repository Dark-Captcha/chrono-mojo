# Hong Kong — ISO 3166-1 alpha-2 "HK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.hong_kong import HONG_KONG


struct HongKong(ImplicitlyCopyable, Movable):
    """Hong Kong — ISO 3166-1 alpha-2 'HK'."""

    comptime CODE = StaticString("HK")
    comptime NAME = StaticString("Hong Kong")
    comptime FLAG = StaticString("🇭🇰")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("en_HK|yue_HK|zh_HK")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[69, 8]]:
        return (HONG_KONG,)
