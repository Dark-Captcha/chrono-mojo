# Liechtenstein — ISO 3166-1 alpha-2 "LI". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.zurich import ZURICH


struct Liechtenstein(ImplicitlyCopyable, Movable):
    """Liechtenstein — ISO 3166-1 alpha-2 'LI'."""

    comptime CODE = StaticString("LI")
    comptime NAME = StaticString("Liechtenstein")
    comptime FLAG = StaticString("🇱🇮")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("de_LI")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[120, 6]]:
        return (ZURICH,)
