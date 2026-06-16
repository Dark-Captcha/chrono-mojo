# Slovenia — ISO 3166-1 alpha-2 "SI". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.belgrade import BELGRADE


struct Slovenia(ImplicitlyCopyable, Movable):
    """Slovenia — ISO 3166-1 alpha-2 'SI'."""

    comptime CODE = StaticString("SI")
    comptime NAME = StaticString("Slovenia")
    comptime FLAG = StaticString("🇸🇮")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("sl_SI")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[119, 7]]:
        return (BELGRADE,)
