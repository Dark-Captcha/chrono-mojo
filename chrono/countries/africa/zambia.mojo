# Zambia — ISO 3166-1 alpha-2 "ZM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.maputo import MAPUTO


struct Zambia(ImplicitlyCopyable, Movable):
    """Zambia — ISO 3166-1 alpha-2 'ZM'."""

    comptime CODE = StaticString("ZM")
    comptime NAME = StaticString("Zambia")
    comptime FLAG = StaticString("🇿🇲")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("bem_ZM|en_ZM")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (MAPUTO,)
