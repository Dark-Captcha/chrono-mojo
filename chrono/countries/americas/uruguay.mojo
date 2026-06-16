# Uruguay — ISO 3166-1 alpha-2 "UY". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.montevideo import MONTEVIDEO


struct Uruguay(ImplicitlyCopyable, Movable):
    """Uruguay — ISO 3166-1 alpha-2 'UY'."""

    comptime CODE = StaticString("UY")
    comptime NAME = StaticString("Uruguay")
    comptime FLAG = StaticString("🇺🇾")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_UY")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[86, 10]]:
        return (MONTEVIDEO,)
