# Germany — ISO 3166-1 alpha-2 "DE". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.europe.zurich import ZURICH
from chrono.timezones.europe.berlin import BERLIN


struct Germany(ImplicitlyCopyable, Movable):
    """Germany — ISO 3166-1 alpha-2 'DE'."""

    comptime CODE = StaticString("DE")
    comptime NAME = StaticString("Germany")
    comptime FLAG = StaticString("🇩🇪")
    comptime CONTINENT = Continent.EUROPE
    comptime LOCALES = StaticString(
        "de_DE|de_DE@euro|dsb_DE|fy_DE|hsb_DE|nds_DE"
    )

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[120, 6], Timezone[143, 9]]:
        return (ZURICH, BERLIN)
