# Zimbabwe — ISO 3166-1 alpha-2 "ZW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.maputo import MAPUTO


struct Zimbabwe(ImplicitlyCopyable, Movable):
    """Zimbabwe — ISO 3166-1 alpha-2 'ZW'."""

    comptime CODE = StaticString("ZW")
    comptime NAME = StaticString("Zimbabwe")
    comptime FLAG = StaticString("🇿🇼")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("en_ZW")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (MAPUTO,)
