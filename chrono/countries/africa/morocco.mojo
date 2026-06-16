# Morocco — ISO 3166-1 alpha-2 "MA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.casablanca import CASABLANCA


struct Morocco(ImplicitlyCopyable, Movable):
    """Morocco — ISO 3166-1 alpha-2 'MA'."""

    comptime CODE = StaticString("MA")
    comptime NAME = StaticString("Morocco")
    comptime FLAG = StaticString("🇲🇦")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ar_MA|ber_MA|rif_MA|zgh_MA")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[197, 5]]:
        return (CASABLANCA,)
