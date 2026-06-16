# Jamaica — ISO 3166-1 alpha-2 "JM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.jamaica import JAMAICA


struct Jamaica(ImplicitlyCopyable, Movable):
    """Jamaica — ISO 3166-1 alpha-2 'JM'."""

    comptime CODE = StaticString("JM")
    comptime NAME = StaticString("Jamaica")
    comptime FLAG = StaticString("🇯🇲")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[22, 4]]:
        return (JAMAICA,)
