# Belgium — ISO 3166-1 alpha-2 "BE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.brussels import BRUSSELS


struct Belgium(ImplicitlyCopyable, Movable):
    """Belgium — ISO 3166-1 alpha-2 'BE'."""

    comptime CODE = StaticString("BE")
    comptime NAME = StaticString("Belgium")
    comptime FLAG = StaticString("🇧🇪")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString(
        "de_BE|de_BE@euro|fr_BE|fr_BE@euro|li_BE|nl_BE|nl_BE@euro|wa_BE|wa_BE@euro"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[185, 12]]:
        return (BRUSSELS,)
