# St Kitts & Nevis — ISO 3166-1 alpha-2 "KN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct StKittsNevis(ImplicitlyCopyable, Movable):
    """St Kitts & Nevis — ISO 3166-1 alpha-2 'KN'."""

    comptime CODE = StaticString("KN")
    comptime NAME = StaticString("St Kitts & Nevis")
    comptime FLAG = StaticString("🇰🇳")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
