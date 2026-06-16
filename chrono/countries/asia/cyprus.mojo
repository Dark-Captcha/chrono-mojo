# Cyprus — ISO 3166-1 alpha-2 "CY". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.nicosia import NICOSIA
from chrono.timezones.asia.famagusta import FAMAGUSTA


struct Cyprus(ImplicitlyCopyable, Movable):
    """Cyprus — ISO 3166-1 alpha-2 'CY'."""

    comptime CODE = StaticString("CY")
    comptime NAME = StaticString("Cyprus")
    comptime FLAG = StaticString("🇨🇾")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("el_CY|tr_CY")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[127, 5], Timezone[126, 7]]:
        return (NICOSIA, FAMAGUSTA)
