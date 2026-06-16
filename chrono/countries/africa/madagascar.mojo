# Madagascar — ISO 3166-1 alpha-2 "MG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Madagascar(ImplicitlyCopyable, Movable):
    """Madagascar — ISO 3166-1 alpha-2 'MG'."""

    comptime CODE = StaticString("MG")
    comptime NAME = StaticString("Madagascar")
    comptime FLAG = StaticString("🇲🇬")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("mg_MG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
