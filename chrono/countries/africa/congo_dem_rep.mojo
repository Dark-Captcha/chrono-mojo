# Congo (Dem. Rep.) — ISO 3166-1 alpha-2 "CD". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.maputo import MAPUTO
from chrono.timezones.africa.lagos import LAGOS


struct CongoDemRep(ImplicitlyCopyable, Movable):
    """Congo (Dem. Rep.) — ISO 3166-1 alpha-2 'CD'."""

    comptime CODE = StaticString("CD")
    comptime NAME = StaticString("Congo (Dem. Rep.)")
    comptime FLAG = StaticString("🇨🇩")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ln_CD")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[1, 2], Timezone[4, 4]]:
        return (MAPUTO, LAGOS)
