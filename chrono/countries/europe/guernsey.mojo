# Guernsey — ISO 3166-1 alpha-2 "GG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.london import LONDON


struct Guernsey(ImplicitlyCopyable, Movable):
    """Guernsey — ISO 3166-1 alpha-2 'GG'."""

    comptime CODE = StaticString("GG")
    comptime NAME = StaticString("Guernsey")
    comptime FLAG = StaticString("🇬🇬")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[242, 8]]:
        return (LONDON,)
