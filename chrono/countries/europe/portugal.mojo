# Portugal — ISO 3166-1 alpha-2 "PT". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.lisbon import LISBON
from chrono.timezones.atlantic.madeira import MADEIRA
from chrono.timezones.atlantic.azores import AZORES


struct Portugal(ImplicitlyCopyable, Movable):
    """Portugal — ISO 3166-1 alpha-2 'PT'."""

    comptime CODE = StaticString("PT")
    comptime NAME = StaticString("Portugal")
    comptime FLAG = StaticString("🇵🇹")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("pt_PT|pt_PT@euro")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[225, 13], Timezone[214, 13], Timezone[216, 15]
    ]:
        return (LISBON, MADEIRA, AZORES)
