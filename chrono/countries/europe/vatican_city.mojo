# Vatican City — ISO 3166-1 alpha-2 "VA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.rome import ROME


struct VaticanCity(ImplicitlyCopyable, Movable):
    """Vatican City — ISO 3166-1 alpha-2 'VA'."""

    comptime CODE = StaticString("VA")
    comptime NAME = StaticString("Vatican City")
    comptime FLAG = StaticString("🇻🇦")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[170, 8]]:
        return (ROME,)
