# Tunisia — ISO 3166-1 alpha-2 "TN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.tunis import TUNIS


struct Tunisia(ImplicitlyCopyable, Movable):
    """Tunisia — ISO 3166-1 alpha-2 'TN'."""

    comptime CODE = StaticString("TN")
    comptime NAME = StaticString("Tunisia")
    comptime FLAG = StaticString("🇹🇳")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ar_TN")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[34, 6]]:
        return (TUNIS,)
