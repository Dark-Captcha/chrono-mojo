# Belarus — ISO 3166-1 alpha-2 "BY". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.minsk import MINSK


struct Belarus(ImplicitlyCopyable, Movable):
    """Belarus — ISO 3166-1 alpha-2 'BY'."""

    comptime CODE = StaticString("BY")
    comptime NAME = StaticString("Belarus")
    comptime FLAG = StaticString("🇧🇾")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("be_BY|be_BY@latin")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[68, 13]]:
        return (MINSK,)
