# Brunei — ISO 3166-1 alpha-2 "BN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.kuching import KUCHING


struct Brunei(ImplicitlyCopyable, Movable):
    """Brunei — ISO 3166-1 alpha-2 'BN'."""

    comptime CODE = StaticString("BN")
    comptime NAME = StaticString("Brunei")
    comptime FLAG = StaticString("🇧🇳")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[18, 6]]:
        return (KUCHING,)
