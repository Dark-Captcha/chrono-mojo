# Tanzania — ISO 3166-1 alpha-2 "TZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Tanzania(ImplicitlyCopyable, Movable):
    """Tanzania — ISO 3166-1 alpha-2 'TZ'."""

    comptime CODE = StaticString("TZ")
    comptime NAME = StaticString("Tanzania")
    comptime FLAG = StaticString("🇹🇿")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("sw_TZ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
