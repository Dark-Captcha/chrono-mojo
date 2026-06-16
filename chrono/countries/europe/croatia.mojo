# Croatia — ISO 3166-1 alpha-2 "HR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.belgrade import BELGRADE


struct Croatia(ImplicitlyCopyable, Movable):
    """Croatia — ISO 3166-1 alpha-2 'HR'."""

    comptime CODE = StaticString("HR")
    comptime NAME = StaticString("Croatia")
    comptime FLAG = StaticString("🇭🇷")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("hr_HR")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[119, 7]]:
        return (BELGRADE,)
