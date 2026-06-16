# Seychelles — ISO 3166-1 alpha-2 "SC". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.dubai import DUBAI


struct Seychelles(ImplicitlyCopyable, Movable):
    """Seychelles — ISO 3166-1 alpha-2 'SC'."""

    comptime CODE = StaticString("SC")
    comptime NAME = StaticString("Seychelles")
    comptime FLAG = StaticString("🇸🇨")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("en_SC")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (DUBAI,)
