# Spain — ISO 3166-1 alpha-2 "ES". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.madrid import MADRID
from chrono.timezones.africa.ceuta import CEUTA
from chrono.timezones.atlantic.canary import CANARY


struct Spain(ImplicitlyCopyable, Movable):
    """Spain — ISO 3166-1 alpha-2 'ES'."""

    comptime CODE = StaticString("ES")
    comptime NAME = StaticString("Spain")
    comptime FLAG = StaticString("🇪🇸")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString(
        "an_ES|ast_ES|ca_ES|ca_ES@euro|ca_ES@valencia|es_ES|es_ES@euro|eu_ES|eu_ES@euro|gl_ES|gl_ES@euro"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[162, 11], Timezone[126, 8], Timezone[118, 6]]:
        return (MADRID, CEUTA, CANARY)
