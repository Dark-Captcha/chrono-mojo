# Benin — ISO 3166-1 alpha-2 "BJ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.lagos import LAGOS


struct Benin(ImplicitlyCopyable, Movable):
    """Benin — ISO 3166-1 alpha-2 'BJ'."""

    comptime CODE = StaticString("BJ")
    comptime NAME = StaticString("Benin")
    comptime FLAG = StaticString("🇧🇯")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (LAGOS,)
