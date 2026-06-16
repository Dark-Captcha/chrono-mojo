# Finland — ISO 3166-1 alpha-2 "FI". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.helsinki import HELSINKI


struct Finland(ImplicitlyCopyable, Movable):
    """Finland — ISO 3166-1 alpha-2 'FI'."""

    comptime CODE = StaticString("FI")
    comptime NAME = StaticString("Finland")
    comptime FLAG = StaticString("🇫🇮")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("fi_FI|fi_FI@euro|sv_FI|sv_FI@euro")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[118, 6]]:
        return (HELSINKI,)
