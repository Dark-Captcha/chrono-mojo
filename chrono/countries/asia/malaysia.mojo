# Malaysia — ISO 3166-1 alpha-2 "MY". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.kuching import KUCHING
from chrono.timezones.asia.singapore import SINGAPORE


struct Malaysia(ImplicitlyCopyable, Movable):
    """Malaysia — ISO 3166-1 alpha-2 'MY'."""

    comptime CODE = StaticString("MY")
    comptime NAME = StaticString("Malaysia")
    comptime FLAG = StaticString("🇲🇾")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("ms_MY")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[18, 6], Timezone[8, 8]]:
        return (KUCHING, SINGAPORE)
