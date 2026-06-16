# Norway — ISO 3166-1 alpha-2 "NO". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.berlin import BERLIN


struct Norway(ImplicitlyCopyable, Movable):
    """Norway — ISO 3166-1 alpha-2 'NO'."""

    comptime CODE = StaticString("NO")
    comptime NAME = StaticString("Norway")
    comptime FLAG = StaticString("🇳🇴")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("nb_NO|nn_NO|se_NO")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[143, 9]]:
        return (BERLIN,)
