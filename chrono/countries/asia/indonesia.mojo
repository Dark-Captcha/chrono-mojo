# Indonesia — ISO 3166-1 alpha-2 "ID". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.jakarta import JAKARTA
from chrono.timezones.asia.pontianak import PONTIANAK
from chrono.timezones.asia.makassar import MAKASSAR
from chrono.timezones.asia.jayapura import JAYAPURA


struct Indonesia(ImplicitlyCopyable, Movable):
    """Indonesia — ISO 3166-1 alpha-2 'ID'."""

    comptime CODE = StaticString("ID")
    comptime NAME = StaticString("Indonesia")
    comptime FLAG = StaticString("🇮🇩")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("id_ID|su_ID")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[8, 7], Timezone[8, 7], Timezone[4, 5], Timezone[3, 4]
    ]:
        return (JAKARTA, PONTIANAK, MAKASSAR, JAYAPURA)
