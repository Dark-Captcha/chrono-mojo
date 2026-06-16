# Argentina — ISO 3166-1 alpha-2 "AR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.argentina_buenos_aires import (
    ARGENTINA_BUENOS_AIRES,
)
from chrono.timezones.america.argentina_cordoba import ARGENTINA_CORDOBA
from chrono.timezones.america.argentina_salta import ARGENTINA_SALTA
from chrono.timezones.america.argentina_jujuy import ARGENTINA_JUJUY
from chrono.timezones.america.argentina_tucuman import ARGENTINA_TUCUMAN
from chrono.timezones.america.argentina_catamarca import ARGENTINA_CATAMARCA
from chrono.timezones.america.argentina_la_rioja import ARGENTINA_LA_RIOJA
from chrono.timezones.america.argentina_san_juan import ARGENTINA_SAN_JUAN
from chrono.timezones.america.argentina_mendoza import ARGENTINA_MENDOZA
from chrono.timezones.america.argentina_san_luis import ARGENTINA_SAN_LUIS
from chrono.timezones.america.argentina_rio_gallegos import (
    ARGENTINA_RIO_GALLEGOS,
)
from chrono.timezones.america.argentina_ushuaia import ARGENTINA_USHUAIA


struct Argentina(ImplicitlyCopyable, Movable):
    """Argentina — ISO 3166-1 alpha-2 'AR'."""

    comptime CODE = StaticString("AR")
    comptime NAME = StaticString("Argentina")
    comptime FLAG = StaticString("🇦🇷")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_AR")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[61, 6],
        Timezone[61, 6],
        Timezone[59, 6],
        Timezone[59, 6],
        Timezone[63, 6],
        Timezone[61, 6],
        Timezone[62, 6],
        Timezone[62, 6],
        Timezone[61, 6],
        Timezone[62, 7],
        Timezone[61, 6],
        Timezone[61, 6],
    ]:
        return (
            ARGENTINA_BUENOS_AIRES,
            ARGENTINA_CORDOBA,
            ARGENTINA_SALTA,
            ARGENTINA_JUJUY,
            ARGENTINA_TUCUMAN,
            ARGENTINA_CATAMARCA,
            ARGENTINA_LA_RIOJA,
            ARGENTINA_SAN_JUAN,
            ARGENTINA_MENDOZA,
            ARGENTINA_SAN_LUIS,
            ARGENTINA_RIO_GALLEGOS,
            ARGENTINA_USHUAIA,
        )
