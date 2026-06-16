# Denmark — ISO 3166-1 alpha-2 "DK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.berlin import BERLIN


struct Denmark(ImplicitlyCopyable, Movable):
    """Denmark — ISO 3166-1 alpha-2 'DK'."""

    comptime CODE = StaticString("DK")
    comptime NAME = StaticString("Denmark")
    comptime FLAG = StaticString("🇩🇰")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("da_DK|en_DK")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[143, 9]]:
        return (BERLIN,)
