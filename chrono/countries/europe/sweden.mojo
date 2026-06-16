# Sweden — ISO 3166-1 alpha-2 "SE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.berlin import BERLIN


struct Sweden(ImplicitlyCopyable, Movable):
    """Sweden — ISO 3166-1 alpha-2 'SE'."""

    comptime CODE = StaticString("SE")
    comptime NAME = StaticString("Sweden")
    comptime FLAG = StaticString("🇸🇪")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("en_SE|sv_SE")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[143, 9]]:
        return (BERLIN,)
