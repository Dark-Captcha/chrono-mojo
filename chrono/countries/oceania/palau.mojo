# Palau — ISO 3166-1 alpha-2 "PW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.palau import PALAU


struct Palau(ImplicitlyCopyable, Movable):
    """Palau — ISO 3166-1 alpha-2 'PW'."""

    comptime CODE = StaticString("PW")
    comptime NAME = StaticString("Palau")
    comptime FLAG = StaticString("🇵🇼")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (PALAU,)
