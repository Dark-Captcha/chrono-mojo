# US minor outlying islands — ISO 3166-1 alpha-2 "UM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.pago_pago import PAGO_PAGO
from chrono.timezones.pacific.tarawa import TARAWA


struct UsMinorOutlyingIslands(ImplicitlyCopyable, Movable):
    """US minor outlying islands — ISO 3166-1 alpha-2 'UM'."""

    comptime CODE = StaticString("UM")
    comptime NAME = StaticString("US minor outlying islands")
    comptime FLAG = StaticString("🇺🇲")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3], Timezone[1, 2]]:
        return (PAGO_PAGO, TARAWA)
