# Sierra Leone — ISO 3166-1 alpha-2 "SL". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.abidjan import ABIDJAN


struct SierraLeone(ImplicitlyCopyable, Movable):
    """Sierra Leone — ISO 3166-1 alpha-2 'SL'."""

    comptime CODE = StaticString("SL")
    comptime NAME = StaticString("Sierra Leone")
    comptime FLAG = StaticString("🇸🇱")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (ABIDJAN,)
