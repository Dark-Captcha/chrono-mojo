# Eswatini (Swaziland) — ISO 3166-1 alpha-2 "SZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.africa.johannesburg import JOHANNESBURG


struct EswatiniSwaziland(ImplicitlyCopyable, Movable):
    """Eswatini (Swaziland) — ISO 3166-1 alpha-2 'SZ'."""

    comptime CODE = StaticString("SZ")
    comptime NAME = StaticString("Eswatini (Swaziland)")
    comptime FLAG = StaticString("🇸🇿")
    comptime CONTINENT = Continent.AFRICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[6, 4]]:
        return (JOHANNESBURG,)
