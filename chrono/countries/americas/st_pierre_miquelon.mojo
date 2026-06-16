# St Pierre & Miquelon — ISO 3166-1 alpha-2 "PM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.miquelon import MIQUELON


struct StPierreMiquelon(ImplicitlyCopyable, Movable):
    """St Pierre & Miquelon — ISO 3166-1 alpha-2 'PM'."""

    comptime CODE = StaticString("PM")
    comptime NAME = StaticString("St Pierre & Miquelon")
    comptime FLAG = StaticString("🇵🇲")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[104, 4]]:
        return (MIQUELON,)
