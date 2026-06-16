# Switzerland — ISO 3166-1 alpha-2 "CH". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.zurich import ZURICH


struct Switzerland(ImplicitlyCopyable, Movable):
    """Switzerland — ISO 3166-1 alpha-2 'CH'."""

    comptime CODE = StaticString("CH")
    comptime NAME = StaticString("Switzerland")
    comptime FLAG = StaticString("🇨🇭")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("de_CH|fr_CH|it_CH|wae_CH")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[120, 6]]:
        return (ZURICH,)
