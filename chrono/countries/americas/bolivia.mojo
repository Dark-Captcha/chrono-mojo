# Bolivia — ISO 3166-1 alpha-2 "BO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.la_paz import LA_PAZ


struct Bolivia(ImplicitlyCopyable, Movable):
    """Bolivia — ISO 3166-1 alpha-2 'BO'."""

    comptime CODE = StaticString("BO")
    comptime NAME = StaticString("Bolivia")
    comptime FLAG = StaticString("🇧🇴")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_BO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[3, 4]]:
        return (LA_PAZ,)
