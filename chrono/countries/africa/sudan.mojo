# Sudan — ISO 3166-1 alpha-2 "SD". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.khartoum import KHARTOUM


struct Sudan(ImplicitlyCopyable, Movable):
    """Sudan — ISO 3166-1 alpha-2 'SD'."""

    comptime CODE = StaticString("SD")
    comptime NAME = StaticString("Sudan")
    comptime FLAG = StaticString("🇸🇩")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ar_SD")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[35, 5]]:
        return (KHARTOUM,)
