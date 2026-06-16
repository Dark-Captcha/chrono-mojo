# Japan — ISO 3166-1 alpha-2 "JP". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.tokyo import TOKYO


struct Japan(ImplicitlyCopyable, Movable):
    """Japan — ISO 3166-1 alpha-2 'JP'."""

    comptime CODE = StaticString("JP")
    comptime NAME = StaticString("Japan")
    comptime FLAG = StaticString("🇯🇵")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ja_JP")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[9, 4]]:
        return (TOKYO,)
