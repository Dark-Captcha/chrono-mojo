# Bhutan — ISO 3166-1 alpha-2 "BT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.thimphu import THIMPHU


struct Bhutan(ImplicitlyCopyable, Movable):
    """Bhutan — ISO 3166-1 alpha-2 'BT'."""

    comptime CODE = StaticString("BT")
    comptime NAME = StaticString("Bhutan")
    comptime FLAG = StaticString("🇧🇹")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("dz_BT")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (THIMPHU,)
