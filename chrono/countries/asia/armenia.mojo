# Armenia — ISO 3166-1 alpha-2 "AM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.yerevan import YEREVAN


struct Armenia(ImplicitlyCopyable, Movable):
    """Armenia — ISO 3166-1 alpha-2 'AM'."""

    comptime CODE = StaticString("AM")
    comptime NAME = StaticString("Armenia")
    comptime FLAG = StaticString("🇦🇲")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("hy_AM")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[62, 10]]:
        return (YEREVAN,)
