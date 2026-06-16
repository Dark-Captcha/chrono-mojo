# Jordan — ISO 3166-1 alpha-2 "JO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.amman import AMMAN


struct Jordan(ImplicitlyCopyable, Movable):
    """Jordan — ISO 3166-1 alpha-2 'JO'."""

    comptime CODE = StaticString("JO")
    comptime NAME = StaticString("Jordan")
    comptime FLAG = StaticString("🇯🇴")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ar_JO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[87, 6]]:
        return (AMMAN,)
