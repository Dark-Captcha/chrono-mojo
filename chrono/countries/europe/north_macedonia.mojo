# North Macedonia — ISO 3166-1 alpha-2 "MK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.belgrade import BELGRADE


struct NorthMacedonia(ImplicitlyCopyable, Movable):
    """North Macedonia — ISO 3166-1 alpha-2 'MK'."""

    comptime CODE = StaticString("MK")
    comptime NAME = StaticString("North Macedonia")
    comptime FLAG = StaticString("🇲🇰")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("mk_MK|sq_MK")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[119, 7]]:
        return (BELGRADE,)
