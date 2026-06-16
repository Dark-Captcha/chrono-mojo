# Equatorial Guinea — ISO 3166-1 alpha-2 "GQ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.lagos import LAGOS


struct EquatorialGuinea(ImplicitlyCopyable, Movable):
    """Equatorial Guinea — ISO 3166-1 alpha-2 'GQ'."""

    comptime CODE = StaticString("GQ")
    comptime NAME = StaticString("Equatorial Guinea")
    comptime FLAG = StaticString("🇬🇶")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[4, 4]]:
        return (LAGOS,)
