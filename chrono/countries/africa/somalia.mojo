# Somalia — ISO 3166-1 alpha-2 "SO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Somalia(ImplicitlyCopyable, Movable):
    """Somalia — ISO 3166-1 alpha-2 'SO'."""

    comptime CODE = StaticString("SO")
    comptime NAME = StaticString("Somalia")
    comptime FLAG = StaticString("🇸🇴")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("so_SO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
