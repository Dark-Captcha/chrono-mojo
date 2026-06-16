# San Marino — ISO 3166-1 alpha-2 "SM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.rome import ROME


struct SanMarino(ImplicitlyCopyable, Movable):
    """San Marino — ISO 3166-1 alpha-2 'SM'."""

    comptime CODE = StaticString("SM")
    comptime NAME = StaticString("San Marino")
    comptime FLAG = StaticString("🇸🇲")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[170, 8]]:
        return (ROME,)
