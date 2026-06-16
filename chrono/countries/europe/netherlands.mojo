# Netherlands — ISO 3166-1 alpha-2 "NL". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.brussels import BRUSSELS


struct Netherlands(ImplicitlyCopyable, Movable):
    """Netherlands — ISO 3166-1 alpha-2 'NL'."""

    comptime CODE = StaticString("NL")
    comptime NAME = StaticString("Netherlands")
    comptime FLAG = StaticString("🇳🇱")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("fy_NL|li_NL|nds_NL|nl_NL|nl_NL@euro")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[185, 12]]:
        return (BRUSSELS,)
