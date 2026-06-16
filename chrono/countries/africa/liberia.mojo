# Liberia — ISO 3166-1 alpha-2 "LR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.monrovia import MONROVIA


struct Liberia(ImplicitlyCopyable, Movable):
    """Liberia — ISO 3166-1 alpha-2 'LR'."""

    comptime CODE = StaticString("LR")
    comptime NAME = StaticString("Liberia")
    comptime FLAG = StaticString("🇱🇷")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[3, 4]]:
        return (MONROVIA,)
