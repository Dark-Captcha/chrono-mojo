# Svalbard & Jan Mayen — ISO 3166-1 alpha-2 "SJ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.berlin import BERLIN


struct SvalbardJanMayen(ImplicitlyCopyable, Movable):
    """Svalbard & Jan Mayen — ISO 3166-1 alpha-2 'SJ'."""

    comptime CODE = StaticString("SJ")
    comptime NAME = StaticString("Svalbard & Jan Mayen")
    comptime FLAG = StaticString("🇸🇯")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[143, 9]]:
        return (BERLIN,)
