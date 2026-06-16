# Qatar — ISO 3166-1 alpha-2 "QA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.qatar import QATAR


struct Qatar(ImplicitlyCopyable, Movable):
    """Qatar — ISO 3166-1 alpha-2 'QA'."""

    comptime CODE = StaticString("QA")
    comptime NAME = StaticString("Qatar")
    comptime FLAG = StaticString("🇶🇦")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_QA")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (QATAR,)
