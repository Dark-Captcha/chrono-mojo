# Maldives — ISO 3166-1 alpha-2 "MV". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.indian.maldives import MALDIVES


struct Maldives(ImplicitlyCopyable, Movable):
    """Maldives — ISO 3166-1 alpha-2 'MV'."""

    comptime CODE = StaticString("MV")
    comptime NAME = StaticString("Maldives")
    comptime FLAG = StaticString("🇲🇻")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("dv_MV")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (MALDIVES,)
