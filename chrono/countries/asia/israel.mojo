# Israel — ISO 3166-1 alpha-2 "IL". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.jerusalem import JERUSALEM


struct Israel(ImplicitlyCopyable, Movable):
    """Israel — ISO 3166-1 alpha-2 'IL'."""

    comptime CODE = StaticString("IL")
    comptime NAME = StaticString("Israel")
    comptime FLAG = StaticString("🇮🇱")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("en_IL|he_IL")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[149, 9]]:
        return (JERUSALEM,)
