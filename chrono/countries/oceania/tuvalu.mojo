# Tuvalu — ISO 3166-1 alpha-2 "TV". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.tarawa import TARAWA


struct Tuvalu(ImplicitlyCopyable, Movable):
    """Tuvalu — ISO 3166-1 alpha-2 'TV'."""

    comptime CODE = StaticString("TV")
    comptime NAME = StaticString("Tuvalu")
    comptime FLAG = StaticString("🇹🇻")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2]]:
        return (TARAWA,)
