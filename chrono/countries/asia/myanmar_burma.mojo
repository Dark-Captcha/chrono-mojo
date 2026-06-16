# Myanmar (Burma) — ISO 3166-1 alpha-2 "MM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.yangon import YANGON


struct MyanmarBurma(ImplicitlyCopyable, Movable):
    """Myanmar (Burma) — ISO 3166-1 alpha-2 'MM'."""

    comptime CODE = StaticString("MM")
    comptime NAME = StaticString("Myanmar (Burma)")
    comptime FLAG = StaticString("🇲🇲")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("mnw_MM|my_MM|shn_MM")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 5]]:
        return (YANGON,)
