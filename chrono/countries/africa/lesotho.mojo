# Lesotho — ISO 3166-1 alpha-2 "LS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.johannesburg import JOHANNESBURG


struct Lesotho(ImplicitlyCopyable, Movable):
    """Lesotho — ISO 3166-1 alpha-2 'LS'."""

    comptime CODE = StaticString("LS")
    comptime NAME = StaticString("Lesotho")
    comptime FLAG = StaticString("🇱🇸")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[6, 4]]:
        return (JOHANNESBURG,)
