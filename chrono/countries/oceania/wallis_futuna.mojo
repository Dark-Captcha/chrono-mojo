# Wallis & Futuna — ISO 3166-1 alpha-2 "WF". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.tarawa import TARAWA


struct WallisFutuna(ImplicitlyCopyable, Movable):
    """Wallis & Futuna — ISO 3166-1 alpha-2 'WF'."""

    comptime CODE = StaticString("WF")
    comptime NAME = StaticString("Wallis & Futuna")
    comptime FLAG = StaticString("🇼🇫")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (TARAWA,)
