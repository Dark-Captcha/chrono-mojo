# French S. Terr. — ISO 3166-1 alpha-2 "TF". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.dubai import DUBAI
from chrono.timezones.indian.maldives import MALDIVES


struct FrenchSTerr(ImplicitlyCopyable, Movable):
    """French S. Terr. — ISO 3166-1 alpha-2 'TF'."""

    comptime CODE = StaticString("TF")
    comptime NAME = StaticString("French S. Terr.")
    comptime FLAG = StaticString("🇹🇫")
    comptime CONTINENT = Continent.ANTARCTICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2], Timezone[2, 3]]:
        return (DUBAI, MALDIVES)
