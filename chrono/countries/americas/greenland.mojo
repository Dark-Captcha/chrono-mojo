# Greenland — ISO 3166-1 alpha-2 "GL". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.nuuk import NUUK
from chrono.timezones.america.danmarkshavn import DANMARKSHAVN
from chrono.timezones.america.scoresbysund import SCORESBYSUND
from chrono.timezones.america.thule import THULE


struct Greenland(ImplicitlyCopyable, Movable):
    """Greenland — ISO 3166-1 alpha-2 'GL'."""

    comptime CODE = StaticString("GL")
    comptime NAME = StaticString("Greenland")
    comptime FLAG = StaticString("🇬🇱")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("kl_GL")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[116, 7], Timezone[34, 6], Timezone[117, 9], Timezone[95, 3]
    ]:
        return (NUUK, DANMARKSHAVN, SCORESBYSUND, THULE)
