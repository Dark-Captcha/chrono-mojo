# Ghana — ISO 3166-1 alpha-2 "GH". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.abidjan import ABIDJAN


struct Ghana(ImplicitlyCopyable, Movable):
    """Ghana — ISO 3166-1 alpha-2 'GH'."""

    comptime CODE = StaticString("GH")
    comptime NAME = StaticString("Ghana")
    comptime FLAG = StaticString("🇬🇭")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ak_GH")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (ABIDJAN,)
