# Korea (South) — ISO 3166-1 alpha-2 "KR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.seoul import SEOUL


struct KoreaSouth(ImplicitlyCopyable, Movable):
    """Korea (South) — ISO 3166-1 alpha-2 'KR'."""

    comptime CODE = StaticString("KR")
    comptime NAME = StaticString("Korea (South)")
    comptime FLAG = StaticString("🇰🇷")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ko_KR")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[29, 7]]:
        return (SEOUL,)
