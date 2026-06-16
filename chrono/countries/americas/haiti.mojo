# Haiti — ISO 3166-1 alpha-2 "HT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.port_au_prince import PORT_AU_PRINCE


struct Haiti(ImplicitlyCopyable, Movable):
    """Haiti — ISO 3166-1 alpha-2 'HT'."""

    comptime CODE = StaticString("HT")
    comptime NAME = StaticString("Haiti")
    comptime FLAG = StaticString("🇭🇹")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("ht_HT")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[86, 6]]:
        return (PORT_AU_PRINCE,)
