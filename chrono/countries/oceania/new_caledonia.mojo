# New Caledonia — ISO 3166-1 alpha-2 "NC". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.noumea import NOUMEA


struct NewCaledonia(ImplicitlyCopyable, Movable):
    """New Caledonia — ISO 3166-1 alpha-2 'NC'."""

    comptime CODE = StaticString("NC")
    comptime NAME = StaticString("New Caledonia")
    comptime FLAG = StaticString("🇳🇨")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[7, 5]]:
        return (NOUMEA,)
