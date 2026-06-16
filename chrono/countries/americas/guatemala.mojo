# Guatemala — ISO 3166-1 alpha-2 "GT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.guatemala import GUATEMALA


struct Guatemala(ImplicitlyCopyable, Movable):
    """Guatemala — ISO 3166-1 alpha-2 'GT'."""

    comptime CODE = StaticString("GT")
    comptime NAME = StaticString("Guatemala")
    comptime FLAG = StaticString("🇬🇹")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_GT")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[9, 3]]:
        return (GUATEMALA,)
