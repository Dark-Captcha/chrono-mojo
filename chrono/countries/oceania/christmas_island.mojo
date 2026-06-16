# Christmas Island — ISO 3166-1 alpha-2 "CX". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.bangkok import BANGKOK


struct ChristmasIsland(ImplicitlyCopyable, Movable):
    """Christmas Island — ISO 3166-1 alpha-2 'CX'."""

    comptime CODE = StaticString("CX")
    comptime NAME = StaticString("Christmas Island")
    comptime FLAG = StaticString("🇨🇽")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (BANGKOK,)
