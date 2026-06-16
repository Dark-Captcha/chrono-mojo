# Korea (North) — ISO 3166-1 alpha-2 "KP". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.asia.pyongyang import PYONGYANG


struct KoreaNorth(ImplicitlyCopyable, Movable):
    """Korea (North) — ISO 3166-1 alpha-2 'KP'."""

    comptime CODE = StaticString("KP")
    comptime NAME = StaticString("Korea (North)")
    comptime FLAG = StaticString("🇰🇵")
    comptime CONTINENT = Continent.ASIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[5, 4]]:
        return (PYONGYANG,)
