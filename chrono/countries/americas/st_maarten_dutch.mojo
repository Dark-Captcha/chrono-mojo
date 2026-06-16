# St Maarten (Dutch) — ISO 3166-1 alpha-2 "SX". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct StMaartenDutch(ImplicitlyCopyable, Movable):
    """St Maarten (Dutch) — ISO 3166-1 alpha-2 'SX'."""

    comptime CODE = StaticString("SX")
    comptime NAME = StaticString("St Maarten (Dutch)")
    comptime FLAG = StaticString("🇸🇽")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
