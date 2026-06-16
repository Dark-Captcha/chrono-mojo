# South Africa — ISO 3166-1 alpha-2 "ZA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.johannesburg import JOHANNESBURG


struct SouthAfrica(ImplicitlyCopyable, Movable):
    """South Africa — ISO 3166-1 alpha-2 'ZA'."""

    comptime CODE = StaticString("ZA")
    comptime NAME = StaticString("South Africa")
    comptime FLAG = StaticString("🇿🇦")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString(
        "af_ZA|en_ZA|nr_ZA|nso_ZA|ss_ZA|st_ZA|tn_ZA|ts_ZA|ve_ZA|xh_ZA|zu_ZA"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[6, 4]]:
        return (JOHANNESBURG,)
