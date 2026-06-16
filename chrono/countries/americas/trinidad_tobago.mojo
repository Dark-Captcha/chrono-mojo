# Trinidad & Tobago — ISO 3166-1 alpha-2 "TT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct TrinidadTobago(ImplicitlyCopyable, Movable):
    """Trinidad & Tobago — ISO 3166-1 alpha-2 'TT'."""

    comptime CODE = StaticString("TT")
    comptime NAME = StaticString("Trinidad & Tobago")
    comptime FLAG = StaticString("🇹🇹")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
