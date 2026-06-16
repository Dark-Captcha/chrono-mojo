# Estonia — ISO 3166-1 alpha-2 "EE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.tallinn import TALLINN


struct Estonia(ImplicitlyCopyable, Movable):
    """Estonia — ISO 3166-1 alpha-2 'EE'."""

    comptime CODE = StaticString("EE")
    comptime NAME = StaticString("Estonia")
    comptime FLAG = StaticString("🇪🇪")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("et_EE")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[123, 15]]:
        return (TALLINN,)
