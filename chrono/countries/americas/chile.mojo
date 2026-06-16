# Chile — ISO 3166-1 alpha-2 "CL". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.santiago import SANTIAGO
from chrono.timezones.america.coyhaique import COYHAIQUE
from chrono.timezones.america.punta_arenas import PUNTA_ARENAS
from chrono.timezones.pacific.easter import EASTER


struct Chile(ImplicitlyCopyable, Movable):
    """Chile — ISO 3166-1 alpha-2 'CL'."""

    comptime CODE = StaticString("CL")
    comptime NAME = StaticString("Chile")
    comptime FLAG = StaticString("🇨🇱")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_CL")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[159, 8], Timezone[133, 8], Timezone[117, 8], Timezone[139, 7]
    ]:
        return (SANTIAGO, COYHAIQUE, PUNTA_ARENAS, EASTER)
