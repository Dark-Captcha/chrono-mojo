# Peru — ISO 3166-1 alpha-2 "PE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.lima import LIMA


struct Peru(ImplicitlyCopyable, Movable):
    """Peru — ISO 3166-1 alpha-2 'PE'."""

    comptime CODE = StaticString("PE")
    comptime NAME = StaticString("Peru")
    comptime FLAG = StaticString("🇵🇪")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("agr_PE|ayc_PE|es_PE|quz_PE")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[16, 4]]:
        return (LIMA,)
