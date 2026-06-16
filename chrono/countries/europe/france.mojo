# France — ISO 3166-1 alpha-2 "FR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.paris import PARIS


struct France(ImplicitlyCopyable, Movable):
    """France — ISO 3166-1 alpha-2 'FR'."""

    comptime CODE = StaticString("FR")
    comptime NAME = StaticString("France")
    comptime FLAG = StaticString("🇫🇷")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString(
        "br_FR|br_FR@euro|ca_FR|fr_FR|fr_FR@euro|ia_FR|oc_FR"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[184, 13]]:
        return (PARIS,)
