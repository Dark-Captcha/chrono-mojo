# Russia — ISO 3166-1 alpha-2 "RU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.kaliningrad import KALININGRAD
from chrono.timezones.europe.moscow import MOSCOW
from chrono.timezones.europe.simferopol import SIMFEROPOL
from chrono.timezones.europe.kirov import KIROV
from chrono.timezones.europe.volgograd import VOLGOGRAD
from chrono.timezones.europe.astrakhan import ASTRAKHAN
from chrono.timezones.europe.saratov import SARATOV
from chrono.timezones.europe.ulyanovsk import ULYANOVSK
from chrono.timezones.europe.samara import SAMARA
from chrono.timezones.asia.yekaterinburg import YEKATERINBURG
from chrono.timezones.asia.omsk import OMSK
from chrono.timezones.asia.novosibirsk import NOVOSIBIRSK
from chrono.timezones.asia.barnaul import BARNAUL
from chrono.timezones.asia.tomsk import TOMSK
from chrono.timezones.asia.novokuznetsk import NOVOKUZNETSK
from chrono.timezones.asia.krasnoyarsk import KRASNOYARSK
from chrono.timezones.asia.irkutsk import IRKUTSK
from chrono.timezones.asia.chita import CHITA
from chrono.timezones.asia.yakutsk import YAKUTSK
from chrono.timezones.asia.khandyga import KHANDYGA
from chrono.timezones.asia.vladivostok import VLADIVOSTOK
from chrono.timezones.asia.ust_nera import UST_NERA
from chrono.timezones.asia.magadan import MAGADAN
from chrono.timezones.asia.sakhalin import SAKHALIN
from chrono.timezones.asia.srednekolymsk import SREDNEKOLYMSK
from chrono.timezones.asia.kamchatka import KAMCHATKA
from chrono.timezones.asia.anadyr import ANADYR


struct Russia(ImplicitlyCopyable, Movable):
    """Russia — ISO 3166-1 alpha-2 'RU'."""

    comptime CODE = StaticString("RU")
    comptime NAME = StaticString("Russia")
    comptime FLAG = StaticString("🇷🇺")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString(
        "ce_RU|crh_RU|cv_RU|kv_RU|mdf_RU|mhr_RU|os_RU|ru_RU|sah_RU|tt_RU|tt_RU@iqtelif"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[80, 15],
        Timezone[78, 17],
        Timezone[75, 16],
        Timezone[63, 10],
        Timezone[65, 10],
        Timezone[64, 9],
        Timezone[64, 9],
        Timezone[66, 12],
        Timezone[64, 11],
        Timezone[66, 12],
        Timezone[65, 11],
        Timezone[67, 10],
        Timezone[67, 10],
        Timezone[67, 10],
        Timezone[64, 9],
        Timezone[65, 11],
        Timezone[66, 12],
        Timezone[66, 11],
        Timezone[65, 11],
        Timezone[67, 13],
        Timezone[65, 11],
        Timezone[66, 12],
        Timezone[66, 11],
        Timezone[66, 9],
        Timezone[65, 11],
        Timezone[64, 9],
        Timezone[64, 10],
    ]:
        return (
            KALININGRAD,
            MOSCOW,
            SIMFEROPOL,
            KIROV,
            VOLGOGRAD,
            ASTRAKHAN,
            SARATOV,
            ULYANOVSK,
            SAMARA,
            YEKATERINBURG,
            OMSK,
            NOVOSIBIRSK,
            BARNAUL,
            TOMSK,
            NOVOKUZNETSK,
            KRASNOYARSK,
            IRKUTSK,
            CHITA,
            YAKUTSK,
            KHANDYGA,
            VLADIVOSTOK,
            UST_NERA,
            MAGADAN,
            SAKHALIN,
            SREDNEKOLYMSK,
            KAMCHATKA,
            ANADYR,
        )
