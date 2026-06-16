# Samoa (western) — ISO 3166-1 alpha-2 "WS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.apia import APIA


struct SamoaWestern(ImplicitlyCopyable, Movable):
    """Samoa (western) — ISO 3166-1 alpha-2 'WS'."""

    comptime CODE = StaticString("WS")
    comptime NAME = StaticString("Samoa (western)")
    comptime FLAG = StaticString("🇼🇸")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("sm_WS")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[26, 7]]:
        return (APIA,)
