# Ethiopia — ISO 3166-1 alpha-2 "ET". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.nairobi import NAIROBI


struct Ethiopia(ImplicitlyCopyable, Movable):
    """Ethiopia — ISO 3166-1 alpha-2 'ET'."""

    comptime CODE = StaticString("ET")
    comptime NAME = StaticString("Ethiopia")
    comptime FLAG = StaticString("🇪🇹")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString(
        "aa_ET|am_ET|gez_ET|gez_ET@abegede|om_ET|sid_ET|so_ET|ti_ET|wal_ET"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 5]]:
        return (NAIROBI,)
