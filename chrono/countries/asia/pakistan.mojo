# Pakistan — ISO 3166-1 alpha-2 "PK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.karachi import KARACHI


struct Pakistan(ImplicitlyCopyable, Movable):
    """Pakistan — ISO 3166-1 alpha-2 'PK'."""

    comptime CODE = StaticString("PK")
    comptime NAME = StaticString("Pakistan")
    comptime FLAG = StaticString("🇵🇰")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("pa_PK|ur_PK")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[11, 6]]:
        return (KARACHI,)
