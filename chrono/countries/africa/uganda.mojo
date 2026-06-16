# Uganda — ISO 3166-1 alpha-2 "UG". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Uganda(ImplicitlyCopyable, Movable):
    """Uganda — ISO 3166-1 alpha-2 'UG'."""

    comptime CODE = StaticString("UG")
    comptime NAME = StaticString("Uganda")
    comptime FLAG = StaticString("🇺🇬")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("lg_UG")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
