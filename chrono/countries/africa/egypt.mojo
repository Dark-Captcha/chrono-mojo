# Egypt — ISO 3166-1 alpha-2 "EG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.cairo import CAIRO


struct Egypt(ImplicitlyCopyable, Movable):
    """Egypt — ISO 3166-1 alpha-2 'EG'."""

    comptime CODE = StaticString("EG")
    comptime NAME = StaticString("Egypt")
    comptime FLAG = StaticString("🇪🇬")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ar_EG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[157, 4]]:
        return (CAIRO,)
