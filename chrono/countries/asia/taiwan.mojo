# Taiwan — ISO 3166-1 alpha-2 "TW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.taipei import TAIPEI


struct Taiwan(ImplicitlyCopyable, Movable):
    """Taiwan — ISO 3166-1 alpha-2 'TW'."""

    comptime CODE = StaticString("TW")
    comptime NAME = StaticString("Taiwan")
    comptime FLAG = StaticString("🇹🇼")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString(
        "cmn_TW|hak_TW|lzh_TW|nan_TW|nan_TW@latin|zh_TW"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[41, 5]]:
        return (TAIPEI,)
