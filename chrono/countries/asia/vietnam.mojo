# Vietnam — ISO 3166-1 alpha-2 "VN". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.bangkok import BANGKOK
from chrono.timezones.asia.ho_chi_minh import HO_CHI_MINH


struct Vietnam(ImplicitlyCopyable, Movable):
    """Vietnam — ISO 3166-1 alpha-2 'VN'."""

    comptime CODE = StaticString("VN")
    comptime NAME = StaticString("Vietnam")
    comptime FLAG = StaticString("🇻🇳")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("vi_VN")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3], Timezone[9, 6]]:
        return (BANGKOK, HO_CHI_MINH)
