# India — ISO 3166-1 alpha-2 "IN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.kolkata import KOLKATA


struct India(ImplicitlyCopyable, Movable):
    """India — ISO 3166-1 alpha-2 'IN'."""

    comptime CODE = StaticString("IN")
    comptime NAME = StaticString("India")
    comptime FLAG = StaticString("🇮🇳")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString(
        "anp_IN|ar_IN|as_IN|bhb_IN|bho_IN|bn_IN|bo_IN|brx_IN|doi_IN|en_IN|gbm_IN|gu_IN|hi_IN|hne_IN|kn_IN|kok_IN|ks_IN|ks_IN@devanagari|mag_IN|mai_IN|mjw_IN|ml_IN|mni_IN|mr_IN|or_IN|pa_IN|raj_IN|sa_IN|sat_IN|sd_IN|sd_IN@devanagari|ta_IN|tcy_IN|te_IN|ur_IN"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[7, 5]]:
        return (KOLKATA,)
