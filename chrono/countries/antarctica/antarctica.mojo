# Antarctica — ISO 3166-1 alpha-2 "AQ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.antarctica.casey import CASEY
from chrono.timezones.antarctica.davis import DAVIS
from chrono.timezones.antarctica.mawson import MAWSON
from chrono.timezones.antarctica.palmer import PALMER
from chrono.timezones.antarctica.rothera import ROTHERA
from chrono.timezones.antarctica.troll import TROLL
from chrono.timezones.antarctica.vostok import VOSTOK
from chrono.timezones.pacific.auckland import AUCKLAND
from chrono.timezones.pacific.port_moresby import PORT_MORESBY
from chrono.timezones.asia.riyadh import RIYADH
from chrono.timezones.asia.singapore import SINGAPORE


struct Antarctica(ImplicitlyCopyable, Movable):
    """Antarctica — ISO 3166-1 alpha-2 'AQ'."""

    comptime CODE = StaticString("AQ")
    comptime NAME = StaticString("Antarctica")
    comptime FLAG = StaticString("🇦🇶")
    comptime CONTINENT = Continent.ANTARCTICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[17, 4],
        Timezone[7, 4],
        Timezone[2, 3],
        Timezone[82, 8],
        Timezone[1, 2],
        Timezone[67, 4],
        Timezone[4, 3],
        Timezone[156, 7],
        Timezone[2, 3],
        Timezone[1, 2],
        Timezone[8, 8],
    ]:
        return (
            CASEY,
            DAVIS,
            MAWSON,
            PALMER,
            ROTHERA,
            TROLL,
            VOSTOK,
            AUCKLAND,
            PORT_MORESBY,
            RIYADH,
            SINGAPORE,
        )
