# Nepal — ISO 3166-1 alpha-2 "NP". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.kathmandu import KATHMANDU


struct Nepal(ImplicitlyCopyable, Movable):
    """Nepal — ISO 3166-1 alpha-2 'NP'."""

    comptime CODE = StaticString("NP")
    comptime NAME = StaticString("Nepal")
    comptime FLAG = StaticString("🇳🇵")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("bho_NP|mai_NP|ne_NP|the_NP")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (KATHMANDU,)
