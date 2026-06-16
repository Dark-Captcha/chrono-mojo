# Micronesia — ISO 3166-1 alpha-2 "FM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.kosrae import KOSRAE
from chrono.timezones.pacific.port_moresby import PORT_MORESBY
from chrono.timezones.pacific.guadalcanal import GUADALCANAL


struct Micronesia(ImplicitlyCopyable, Movable):
    """Micronesia — ISO 3166-1 alpha-2 'FM'."""

    comptime CODE = StaticString("FM")
    comptime NAME = StaticString("Micronesia")
    comptime FLAG = StaticString("🇫🇲")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[9, 7], Timezone[2, 3], Timezone[1, 2]]:
        return (KOSRAE, PORT_MORESBY, GUADALCANAL)
