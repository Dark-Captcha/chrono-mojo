# Tokelau — ISO 3166-1 alpha-2 "TK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.fakaofo import FAKAOFO


struct Tokelau(ImplicitlyCopyable, Movable):
    """Tokelau — ISO 3166-1 alpha-2 'TK'."""

    comptime CODE = StaticString("TK")
    comptime NAME = StaticString("Tokelau")
    comptime FLAG = StaticString("🇹🇰")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (FAKAOFO,)
