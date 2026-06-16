# El Salvador — ISO 3166-1 alpha-2 "SV". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.el_salvador import EL_SALVADOR


struct ElSalvador(ImplicitlyCopyable, Movable):
    """El Salvador — ISO 3166-1 alpha-2 'SV'."""

    comptime CODE = StaticString("SV")
    comptime NAME = StaticString("El Salvador")
    comptime FLAG = StaticString("🇸🇻")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_SV")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 3]]:
        return (EL_SALVADOR,)
