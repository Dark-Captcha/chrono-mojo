# Malawi — ISO 3166-1 alpha-2 "MW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.maputo import MAPUTO


struct Malawi(ImplicitlyCopyable, Movable):
    """Malawi — ISO 3166-1 alpha-2 'MW'."""

    comptime CODE = StaticString("MW")
    comptime NAME = StaticString("Malawi")
    comptime FLAG = StaticString("🇲🇼")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (MAPUTO,)
