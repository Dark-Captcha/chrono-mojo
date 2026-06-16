# Iraq — ISO 3166-1 alpha-2 "IQ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.baghdad import BAGHDAD


struct Iraq(ImplicitlyCopyable, Movable):
    """Iraq — ISO 3166-1 alpha-2 'IQ'."""

    comptime CODE = StaticString("IQ")
    comptime NAME = StaticString("Iraq")
    comptime FLAG = StaticString("🇮🇶")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_IQ|ckb_IQ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[54, 6]]:
        return (BAGHDAD,)
