# Vanuatu — ISO 3166-1 alpha-2 "VU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.efate import EFATE


struct Vanuatu(ImplicitlyCopyable, Movable):
    """Vanuatu — ISO 3166-1 alpha-2 'VU'."""

    comptime CODE = StaticString("VU")
    comptime NAME = StaticString("Vanuatu")
    comptime FLAG = StaticString("🇻🇺")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("bi_VU")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[23, 5]]:
        return (EFATE,)
