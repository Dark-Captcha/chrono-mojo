# Iceland — ISO 3166-1 alpha-2 "IS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.abidjan import ABIDJAN


struct Iceland(ImplicitlyCopyable, Movable):
    """Iceland — ISO 3166-1 alpha-2 'IS'."""

    comptime CODE = StaticString("IS")
    comptime NAME = StaticString("Iceland")
    comptime FLAG = StaticString("🇮🇸")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("is_IS")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (ABIDJAN,)
