# Philippines — ISO 3166-1 alpha-2 "PH". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.manila import MANILA


struct Philippines(ImplicitlyCopyable, Movable):
    """Philippines — ISO 3166-1 alpha-2 'PH'."""

    comptime CODE = StaticString("PH")
    comptime NAME = StaticString("Philippines")
    comptime FLAG = StaticString("🇵🇭")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("en_PH|fil_PH|tl_PH")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[14, 7]]:
        return (MANILA,)
