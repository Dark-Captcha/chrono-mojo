# Venezuela — ISO 3166-1 alpha-2 "VE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.caracas import CARACAS


struct Venezuela(ImplicitlyCopyable, Movable):
    """Venezuela — ISO 3166-1 alpha-2 'VE'."""

    comptime CODE = StaticString("VE")
    comptime NAME = StaticString("Venezuela")
    comptime FLAG = StaticString("🇻🇪")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_VE")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 4]]:
        return (CARACAS,)
