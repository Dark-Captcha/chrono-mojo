# Falkland Islands — ISO 3166-1 alpha-2 "FK". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.atlantic.stanley import STANLEY


struct FalklandIslands(ImplicitlyCopyable, Movable):
    """Falkland Islands — ISO 3166-1 alpha-2 'FK'."""

    comptime CODE = StaticString("FK")
    comptime NAME = StaticString("Falkland Islands")
    comptime FLAG = StaticString("🇫🇰")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[70, 7]]:
        return (STANLEY,)
