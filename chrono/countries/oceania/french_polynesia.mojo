# French Polynesia — ISO 3166-1 alpha-2 "PF". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.tahiti import TAHITI
from chrono.timezones.pacific.marquesas import MARQUESAS
from chrono.timezones.pacific.gambier import GAMBIER


struct FrenchPolynesia(ImplicitlyCopyable, Movable):
    """French Polynesia — ISO 3166-1 alpha-2 'PF'."""

    comptime CODE = StaticString("PF")
    comptime NAME = StaticString("French Polynesia")
    comptime FLAG = StaticString("🇵🇫")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2], Timezone[1, 2], Timezone[1, 2]]:
        return (TAHITI, MARQUESAS, GAMBIER)
