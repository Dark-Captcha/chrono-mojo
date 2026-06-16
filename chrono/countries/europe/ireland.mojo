# Ireland — ISO 3166-1 alpha-2 "IE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.dublin import DUBLIN


struct Ireland(ImplicitlyCopyable, Movable):
    """Ireland — ISO 3166-1 alpha-2 'IE'."""

    comptime CODE = StaticString("IE")
    comptime NAME = StaticString("Ireland")
    comptime FLAG = StaticString("🇮🇪")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString("en_IE|en_IE@euro|ga_IE|ga_IE@euro")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[228, 9]]:
        return (DUBLIN,)
