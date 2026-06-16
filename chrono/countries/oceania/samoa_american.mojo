# Samoa (American) — ISO 3166-1 alpha-2 "AS". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.pago_pago import PAGO_PAGO


struct SamoaAmerican(ImplicitlyCopyable, Movable):
    """Samoa (American) — ISO 3166-1 alpha-2 'AS'."""

    comptime CODE = StaticString("AS")
    comptime NAME = StaticString("Samoa (American)")
    comptime FLAG = StaticString("🇦🇸")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[2, 3]]:
        return (PAGO_PAGO,)
