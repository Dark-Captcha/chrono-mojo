# Kazakhstan — ISO 3166-1 alpha-2 "KZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.almaty import ALMATY
from chrono.timezones.asia.qyzylorda import QYZYLORDA
from chrono.timezones.asia.qostanay import QOSTANAY
from chrono.timezones.asia.aqtobe import AQTOBE
from chrono.timezones.asia.aqtau import AQTAU
from chrono.timezones.asia.atyrau import ATYRAU
from chrono.timezones.asia.oral import ORAL


struct Kazakhstan(ImplicitlyCopyable, Movable):
    """Kazakhstan — ISO 3166-1 alpha-2 'KZ'."""

    comptime CODE = StaticString("KZ")
    comptime NAME = StaticString("Kazakhstan")
    comptime FLAG = StaticString("🇰🇿")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("kk_KZ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[52, 9],
        Timezone[52, 11],
        Timezone[52, 12],
        Timezone[51, 11],
        Timezone[50, 10],
        Timezone[50, 10],
        Timezone[51, 10],
    ]:
        return (ALMATY, QYZYLORDA, QOSTANAY, AQTOBE, AQTAU, ATYRAU, ORAL)
