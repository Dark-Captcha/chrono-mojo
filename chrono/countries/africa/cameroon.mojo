# Cameroon — ISO 3166-1 alpha-2 "CM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.lagos import LAGOS


struct Cameroon(ImplicitlyCopyable, Movable):
    """Cameroon — ISO 3166-1 alpha-2 'CM'."""

    comptime CODE = StaticString("CM")
    comptime NAME = StaticString("Cameroon")
    comptime FLAG = StaticString("🇨🇲")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (LAGOS,)
