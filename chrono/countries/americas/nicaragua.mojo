# Nicaragua — ISO 3166-1 alpha-2 "NI". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.managua import MANAGUA


struct Nicaragua(ImplicitlyCopyable, Movable):
    """Nicaragua — ISO 3166-1 alpha-2 'NI'."""

    comptime CODE = StaticString("NI")
    comptime NAME = StaticString("Nicaragua")
    comptime FLAG = StaticString("🇳🇮")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_NI|miq_NI")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[16, 6]]:
        return (MANAGUA,)
