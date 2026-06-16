# Guinea-Bissau — ISO 3166-1 alpha-2 "GW". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.bissau import BISSAU


struct GuineaBissau(ImplicitlyCopyable, Movable):
    """Guinea-Bissau — ISO 3166-1 alpha-2 'GW'."""

    comptime CODE = StaticString("GW")
    comptime NAME = StaticString("Guinea-Bissau")
    comptime FLAG = StaticString("🇬🇼")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (BISSAU,)
