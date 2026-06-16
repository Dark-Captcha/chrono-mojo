# Aruba — ISO 3166-1 alpha-2 "AW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.puerto_rico import PUERTO_RICO


struct Aruba(ImplicitlyCopyable, Movable):
    """Aruba — ISO 3166-1 alpha-2 'AW'."""

    comptime CODE = StaticString("AW")
    comptime NAME = StaticString("Aruba")
    comptime FLAG = StaticString("🇦🇼")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("nl_AW|pap_AW")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (PUERTO_RICO,)
