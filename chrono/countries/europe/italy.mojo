# Italy — ISO 3166-1 alpha-2 "IT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.rome import ROME


struct Italy(ImplicitlyCopyable, Movable):
    """Italy — ISO 3166-1 alpha-2 'IT'."""

    comptime CODE = StaticString("IT")
    comptime NAME = StaticString("Italy")
    comptime FLAG = StaticString("🇮🇹")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString(
        "ca_IT|de_IT|fur_IT|it_IT|it_IT@euro|lij_IT|sc_IT|scn_IT"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[170, 8]]:
        return (ROME,)
