# Mauritius — ISO 3166-1 alpha-2 "MU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.indian.mauritius import MAURITIUS


struct Mauritius(ImplicitlyCopyable, Movable):
    """Mauritius — ISO 3166-1 alpha-2 'MU'."""

    comptime CODE = StaticString("MU")
    comptime NAME = StaticString("Mauritius")
    comptime FLAG = StaticString("🇲🇺")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("mfe_MU")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 3]]:
        return (MAURITIUS,)
