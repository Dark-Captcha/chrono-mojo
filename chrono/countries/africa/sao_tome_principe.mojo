# Sao Tome & Principe — ISO 3166-1 alpha-2 "ST". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.sao_tome import SAO_TOME


struct SaoTomePrincipe(ImplicitlyCopyable, Movable):
    """Sao Tome & Principe — ISO 3166-1 alpha-2 'ST'."""

    comptime CODE = StaticString("ST")
    comptime NAME = StaticString("Sao Tome & Principe")
    comptime FLAG = StaticString("🇸🇹")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 5]]:
        return (SAO_TOME,)
