# Chad — ISO 3166-1 alpha-2 "TD". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.ndjamena import NDJAMENA


struct Chad(ImplicitlyCopyable, Movable):
    """Chad — ISO 3166-1 alpha-2 'TD'."""

    comptime CODE = StaticString("TD")
    comptime NAME = StaticString("Chad")
    comptime FLAG = StaticString("🇹🇩")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[3, 3]]:
        return (NDJAMENA,)
