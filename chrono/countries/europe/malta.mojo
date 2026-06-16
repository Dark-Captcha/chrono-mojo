# Malta — ISO 3166-1 alpha-2 "MT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.malta import MALTA


struct Malta(ImplicitlyCopyable, Movable):
    """Malta — ISO 3166-1 alpha-2 'MT'."""

    comptime CODE = StaticString("MT")
    comptime NAME = StaticString("Malta")
    comptime FLAG = StaticString("🇲🇹")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("mt_MT")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[169, 7]]:
        return (MALTA,)
