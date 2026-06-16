# Tonga — ISO 3166-1 alpha-2 "TO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.tongatapu import TONGATAPU


struct Tonga(ImplicitlyCopyable, Movable):
    """Tonga — ISO 3166-1 alpha-2 'TO'."""

    comptime CODE = StaticString("TO")
    comptime NAME = StaticString("Tonga")
    comptime FLAG = StaticString("🇹🇴")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("to_TO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[10, 6]]:
        return (TONGATAPU,)
