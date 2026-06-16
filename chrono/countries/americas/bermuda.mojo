# Bermuda — ISO 3166-1 alpha-2 "BM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.atlantic.bermuda import BERMUDA


struct Bermuda(ImplicitlyCopyable, Movable):
    """Bermuda — ISO 3166-1 alpha-2 'BM'."""

    comptime CODE = StaticString("BM")
    comptime NAME = StaticString("Bermuda")
    comptime FLAG = StaticString("🇧🇲")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[156, 5]]:
        return (BERMUDA,)
