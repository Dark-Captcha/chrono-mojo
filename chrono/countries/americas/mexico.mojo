# Mexico — ISO 3166-1 alpha-2 "MX". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.mexico_city import MEXICO_CITY
from chrono.timezones.america.cancun import CANCUN
from chrono.timezones.america.merida import MERIDA
from chrono.timezones.america.monterrey import MONTERREY
from chrono.timezones.america.matamoros import MATAMOROS
from chrono.timezones.america.chihuahua import CHIHUAHUA
from chrono.timezones.america.ciudad_juarez import CIUDAD_JUAREZ
from chrono.timezones.america.ojinaga import OJINAGA
from chrono.timezones.america.mazatlan import MAZATLAN
from chrono.timezones.america.bahia_banderas import BAHIA_BANDERAS
from chrono.timezones.america.hermosillo import HERMOSILLO
from chrono.timezones.america.tijuana import TIJUANA


struct Mexico(ImplicitlyCopyable, Movable):
    """Mexico — ISO 3166-1 alpha-2 'MX'."""

    comptime CODE = StaticString("MX")
    comptime NAME = StaticString("Mexico")
    comptime FLAG = StaticString("🇲🇽")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_MX|nhn_MX")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[68, 8],
        Timezone[43, 8],
        Timezone[57, 5],
        Timezone[62, 7],
        Timezone[87, 4],
        Timezone[60, 8],
        Timezone[91, 7],
        Timezone[90, 7],
        Timezone[61, 5],
        Timezone[61, 7],
        Timezone[13, 5],
        Timezone[187, 8],
    ]:
        return (
            MEXICO_CITY,
            CANCUN,
            MERIDA,
            MONTERREY,
            MATAMOROS,
            CHIHUAHUA,
            CIUDAD_JUAREZ,
            OJINAGA,
            MAZATLAN,
            BAHIA_BANDERAS,
            HERMOSILLO,
            TIJUANA,
        )
