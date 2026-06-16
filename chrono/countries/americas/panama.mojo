# Panama — ISO 3166-1 alpha-2 "PA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.panama import PANAMA


struct Panama(ImplicitlyCopyable, Movable):
    """Panama — ISO 3166-1 alpha-2 'PA'."""

    comptime CODE = StaticString("PA")
    comptime NAME = StaticString("Panama")
    comptime FLAG = StaticString("🇵🇦")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_PA")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (PANAMA,)
