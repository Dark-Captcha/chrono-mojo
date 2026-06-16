# Fiji — ISO 3166-1 alpha-2 "FJ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.fiji import FIJI


struct Fiji(ImplicitlyCopyable, Movable):
    """Fiji — ISO 3166-1 alpha-2 'FJ'."""

    comptime CODE = StaticString("FJ")
    comptime NAME = StaticString("Fiji")
    comptime FLAG = StaticString("🇫🇯")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("hif_FJ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[29, 3]]:
        return (FIJI,)
