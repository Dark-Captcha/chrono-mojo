# United States — ISO 3166-1 alpha-2 "US". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.new_york import NEW_YORK
from chrono.timezones.america.detroit import DETROIT
from chrono.timezones.america.kentucky_louisville import KENTUCKY_LOUISVILLE
from chrono.timezones.america.kentucky_monticello import KENTUCKY_MONTICELLO
from chrono.timezones.america.indiana_indianapolis import INDIANA_INDIANAPOLIS
from chrono.timezones.america.indiana_vincennes import INDIANA_VINCENNES
from chrono.timezones.america.indiana_winamac import INDIANA_WINAMAC
from chrono.timezones.america.indiana_marengo import INDIANA_MARENGO
from chrono.timezones.america.indiana_petersburg import INDIANA_PETERSBURG
from chrono.timezones.america.indiana_vevay import INDIANA_VEVAY
from chrono.timezones.america.chicago import CHICAGO
from chrono.timezones.america.indiana_tell_city import INDIANA_TELL_CITY
from chrono.timezones.america.indiana_knox import INDIANA_KNOX
from chrono.timezones.america.menominee import MENOMINEE
from chrono.timezones.america.north_dakota_center import NORTH_DAKOTA_CENTER
from chrono.timezones.america.north_dakota_new_salem import (
    NORTH_DAKOTA_NEW_SALEM,
)
from chrono.timezones.america.north_dakota_beulah import NORTH_DAKOTA_BEULAH
from chrono.timezones.america.denver import DENVER
from chrono.timezones.america.boise import BOISE
from chrono.timezones.america.phoenix import PHOENIX
from chrono.timezones.america.los_angeles import LOS_ANGELES
from chrono.timezones.america.anchorage import ANCHORAGE
from chrono.timezones.america.juneau import JUNEAU
from chrono.timezones.america.sitka import SITKA
from chrono.timezones.america.metlakatla import METLAKATLA
from chrono.timezones.america.yakutat import YAKUTAT
from chrono.timezones.america.nome import NOME
from chrono.timezones.america.adak import ADAK
from chrono.timezones.pacific.honolulu import HONOLULU


struct UnitedStates(ImplicitlyCopyable, Movable):
    """United States — ISO 3166-1 alpha-2 'US'."""

    comptime CODE = StaticString("US")
    comptime NAME = StaticString("United States")
    comptime FLAG = StaticString("🇺🇸")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("chr_US|en_US|es_US|unm_US|yi_US")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[236, 6],
        Timezone[141, 6],
        Timezone[178, 8],
        Timezone[148, 8],
        Timezone[99, 8],
        Timezone[101, 8],
        Timezone[107, 8],
        Timezone[103, 8],
        Timezone[116, 8],
        Timezone[81, 8],
        Timezone[236, 8],
        Timezone[98, 10],
        Timezone[154, 8],
        Timezone[143, 7],
        Timezone[150, 8],
        Timezone[150, 8],
        Timezone[150, 8],
        Timezone[158, 6],
        Timezone[151, 8],
        Timezone[11, 5],
        Timezone[186, 6],
        Timezone[145, 10],
        Timezone[144, 10],
        Timezone[144, 9],
        Timezone[81, 8],
        Timezone[144, 8],
        Timezone[145, 10],
        Timezone[145, 10],
        Timezone[7, 6],
    ]:
        return (
            NEW_YORK,
            DETROIT,
            KENTUCKY_LOUISVILLE,
            KENTUCKY_MONTICELLO,
            INDIANA_INDIANAPOLIS,
            INDIANA_VINCENNES,
            INDIANA_WINAMAC,
            INDIANA_MARENGO,
            INDIANA_PETERSBURG,
            INDIANA_VEVAY,
            CHICAGO,
            INDIANA_TELL_CITY,
            INDIANA_KNOX,
            MENOMINEE,
            NORTH_DAKOTA_CENTER,
            NORTH_DAKOTA_NEW_SALEM,
            NORTH_DAKOTA_BEULAH,
            DENVER,
            BOISE,
            PHOENIX,
            LOS_ANGELES,
            ANCHORAGE,
            JUNEAU,
            SITKA,
            METLAKATLA,
            YAKUTAT,
            NOME,
            ADAK,
            HONOLULU,
        )
