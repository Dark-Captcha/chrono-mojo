# Britain (UK) — ISO 3166-1 alpha-2 "GB". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.london import LONDON


struct BritainUk(ImplicitlyCopyable, Movable):
    """Britain (UK) — ISO 3166-1 alpha-2 'GB'."""

    comptime CODE = StaticString("GB")
    comptime NAME = StaticString("Britain (UK)")
    comptime FLAG = StaticString("🇬🇧")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("cy_GB|en_GB|gd_GB|gv_GB|kw_GB")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[242, 8]]:
        return (LONDON,)
