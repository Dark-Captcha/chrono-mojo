# Laos — ISO 3166-1 alpha-2 "LA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.bangkok import BANGKOK


struct Laos(ImplicitlyCopyable, Movable):
    """Laos — ISO 3166-1 alpha-2 'LA'."""

    comptime CODE = StaticString("LA")
    comptime NAME = StaticString("Laos")
    comptime FLAG = StaticString("🇱🇦")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("lo_LA")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (BANGKOK,)
