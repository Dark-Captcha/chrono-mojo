# Nigeria — ISO 3166-1 alpha-2 "NG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.lagos import LAGOS


struct Nigeria(ImplicitlyCopyable, Movable):
    """Nigeria — ISO 3166-1 alpha-2 'NG'."""

    comptime CODE = StaticString("NG")
    comptime NAME = StaticString("Nigeria")
    comptime FLAG = StaticString("🇳🇬")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("en_NG|ha_NG|ig_NG|yo_NG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (LAGOS,)
