# Slovakia — ISO 3166-1 alpha-2 "SK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.prague import PRAGUE


struct Slovakia(ImplicitlyCopyable, Movable):
    """Slovakia — ISO 3166-1 alpha-2 'SK'."""

    comptime CODE = StaticString("SK")
    comptime NAME = StaticString("Slovakia")
    comptime FLAG = StaticString("🇸🇰")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("sk_SK")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[144, 9]]:
        return (PRAGUE,)
