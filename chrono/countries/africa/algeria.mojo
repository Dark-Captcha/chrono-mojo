# Algeria — ISO 3166-1 alpha-2 "DZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.algiers import ALGIERS


struct Algeria(ImplicitlyCopyable, Movable):
    """Algeria — ISO 3166-1 alpha-2 'DZ'."""

    comptime CODE = StaticString("DZ")
    comptime NAME = StaticString("Algeria")
    comptime FLAG = StaticString("🇩🇿")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("ar_DZ|ber_DZ|kab_DZ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[34, 8]]:
        return (ALGIERS,)
