# Turkey — ISO 3166-1 alpha-2 "TR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.istanbul import ISTANBUL


struct Turkey(ImplicitlyCopyable, Movable):
    """Turkey — ISO 3166-1 alpha-2 'TR'."""

    comptime CODE = StaticString("TR")
    comptime NAME = StaticString("Turkey")
    comptime FLAG = StaticString("🇹🇷")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ku_TR|tr_TR")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[115, 11]]:
        return (ISTANBUL,)
