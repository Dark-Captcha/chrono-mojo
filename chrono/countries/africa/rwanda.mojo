# Rwanda — ISO 3166-1 alpha-2 "RW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.maputo import MAPUTO


struct Rwanda(ImplicitlyCopyable, Movable):
    """Rwanda — ISO 3166-1 alpha-2 'RW'."""

    comptime CODE = StaticString("RW")
    comptime NAME = StaticString("Rwanda")
    comptime FLAG = StaticString("🇷🇼")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("rw_RW")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (MAPUTO,)
