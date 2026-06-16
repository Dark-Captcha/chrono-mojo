# Uzbekistan — ISO 3166-1 alpha-2 "UZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.samarkand import SAMARKAND
from chrono.timezones.asia.tashkent import TASHKENT


struct Uzbekistan(ImplicitlyCopyable, Movable):
    """Uzbekistan — ISO 3166-1 alpha-2 'UZ'."""

    comptime CODE = StaticString("UZ")
    comptime NAME = StaticString("Uzbekistan")
    comptime FLAG = StaticString("🇺🇿")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("uz_UZ|uz_UZ@cyrillic")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[24, 7], Timezone[24, 8]]:
        return (SAMARKAND, TASHKENT)
