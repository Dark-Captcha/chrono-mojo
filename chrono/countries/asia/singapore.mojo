# Singapore — ISO 3166-1 alpha-2 "SG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.singapore import SINGAPORE


struct Singapore(ImplicitlyCopyable, Movable):
    """Singapore — ISO 3166-1 alpha-2 'SG'."""

    comptime CODE = StaticString("SG")
    comptime NAME = StaticString("Singapore")
    comptime FLAG = StaticString("🇸🇬")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("en_SG|zh_SG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[8, 8]]:
        return (SINGAPORE,)
