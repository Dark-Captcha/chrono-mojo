# Palestine — ISO 3166-1 alpha-2 "PS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.gaza import GAZA
from chrono.timezones.asia.hebron import HEBRON


struct Palestine(ImplicitlyCopyable, Movable):
    """Palestine — ISO 3166-1 alpha-2 'PS'."""

    comptime CODE = StaticString("PS")
    comptime NAME = StaticString("Palestine")
    comptime FLAG = StaticString("🇵🇸")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[308, 10], Timezone[310, 10]]:
        return (GAZA, HEBRON)
