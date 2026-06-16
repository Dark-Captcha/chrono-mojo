# Bosnia & Herzegovina — ISO 3166-1 alpha-2 "BA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.belgrade import BELGRADE


struct BosniaHerzegovina(ImplicitlyCopyable, Movable):
    """Bosnia & Herzegovina — ISO 3166-1 alpha-2 'BA'."""

    comptime CODE = StaticString("BA")
    comptime NAME = StaticString("Bosnia & Herzegovina")
    comptime FLAG = StaticString("🇧🇦")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("bs_BA")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[119, 7]]:
        return (BELGRADE,)
