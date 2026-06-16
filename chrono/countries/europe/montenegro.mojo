# Montenegro — ISO 3166-1 alpha-2 "ME". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.belgrade import BELGRADE


struct Montenegro(ImplicitlyCopyable, Movable):
    """Montenegro — ISO 3166-1 alpha-2 'ME'."""

    comptime CODE = StaticString("ME")
    comptime NAME = StaticString("Montenegro")
    comptime FLAG = StaticString("🇲🇪")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("sr_ME")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[119, 7]]:
        return (BELGRADE,)
