# Turks & Caicos Is — ISO 3166-1 alpha-2 "TC". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.grand_turk import GRAND_TURK


struct TurksCaicosIs(ImplicitlyCopyable, Movable):
    """Turks & Caicos Is — ISO 3166-1 alpha-2 'TC'."""

    comptime CODE = StaticString("TC")
    comptime NAME = StaticString("Turks & Caicos Is")
    comptime FLAG = StaticString("🇹🇨")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[115, 6]]:
        return (GRAND_TURK,)
