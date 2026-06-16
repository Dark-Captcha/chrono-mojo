# Kiribati — ISO 3166-1 alpha-2 "KI". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.tarawa import TARAWA
from chrono.timezones.pacific.kanton import KANTON
from chrono.timezones.pacific.kiritimati import KIRITIMATI


struct Kiribati(ImplicitlyCopyable, Movable):
    """Kiribati — ISO 3166-1 alpha-2 'KI'."""

    comptime CODE = StaticString("KI")
    comptime NAME = StaticString("Kiribati")
    comptime FLAG = StaticString("🇰🇮")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2], Timezone[3, 4], Timezone[3, 4]]:
        return (TARAWA, KANTON, KIRITIMATI)
