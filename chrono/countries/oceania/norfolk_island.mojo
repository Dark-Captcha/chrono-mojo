# Norfolk Island — ISO 3166-1 alpha-2 "NF". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.norfolk import NORFOLK


struct NorfolkIsland(ImplicitlyCopyable, Movable):
    """Norfolk Island — ISO 3166-1 alpha-2 'NF'."""

    comptime CODE = StaticString("NF")
    comptime NAME = StaticString("Norfolk Island")
    comptime FLAG = StaticString("🇳🇫")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[42, 7]]:
        return (NORFOLK,)
