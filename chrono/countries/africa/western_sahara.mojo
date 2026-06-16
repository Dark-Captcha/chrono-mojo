# Western Sahara — ISO 3166-1 alpha-2 "EH". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.el_aaiun import EL_AAIUN


struct WesternSahara(ImplicitlyCopyable, Movable):
    """Western Sahara — ISO 3166-1 alpha-2 'EH'."""

    comptime CODE = StaticString("EH")
    comptime NAME = StaticString("Western Sahara")
    comptime FLAG = StaticString("🇪🇭")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[186, 6]]:
        return (EL_AAIUN,)
