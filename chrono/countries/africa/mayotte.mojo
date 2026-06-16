# Mayotte — ISO 3166-1 alpha-2 "YT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Mayotte(ImplicitlyCopyable, Movable):
    """Mayotte — ISO 3166-1 alpha-2 'YT'."""

    comptime CODE = StaticString("YT")
    comptime NAME = StaticString("Mayotte")
    comptime FLAG = StaticString("🇾🇹")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
