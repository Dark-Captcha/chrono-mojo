# Niue — ISO 3166-1 alpha-2 "NU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.niue import NIUE


struct Niue(ImplicitlyCopyable, Movable):
    """Niue — ISO 3166-1 alpha-2 'NU'."""

    comptime CODE = StaticString("NU")
    comptime NAME = StaticString("Niue")
    comptime FLAG = StaticString("🇳🇺")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("niu_NU")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (NIUE,)
