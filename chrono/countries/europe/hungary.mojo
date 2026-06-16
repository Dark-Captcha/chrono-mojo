# Hungary — ISO 3166-1 alpha-2 "HU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.budapest import BUDAPEST


struct Hungary(ImplicitlyCopyable, Movable):
    """Hungary — ISO 3166-1 alpha-2 'HU'."""

    comptime CODE = StaticString("HU")
    comptime NAME = StaticString("Hungary")
    comptime FLAG = StaticString("🇭🇺")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("hu_HU")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[151, 7]]:
        return (BUDAPEST,)
