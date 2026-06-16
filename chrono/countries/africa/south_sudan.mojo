# South Sudan — ISO 3166-1 alpha-2 "SS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.juba import JUBA


struct SouthSudan(ImplicitlyCopyable, Movable):
    """South Sudan — ISO 3166-1 alpha-2 'SS'."""

    comptime CODE = StaticString("SS")
    comptime NAME = StaticString("South Sudan")
    comptime FLAG = StaticString("🇸🇸")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ar_SS")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[35, 5]]:
        return (JUBA,)
