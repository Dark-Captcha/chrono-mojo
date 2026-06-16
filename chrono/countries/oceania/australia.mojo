# Australia — ISO 3166-1 alpha-2 "AU". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.australia.lord_howe import LORD_HOWE
from chrono.timezones.antarctica.macquarie import MACQUARIE
from chrono.timezones.australia.hobart import HOBART
from chrono.timezones.australia.melbourne import MELBOURNE
from chrono.timezones.australia.sydney import SYDNEY
from chrono.timezones.australia.broken_hill import BROKEN_HILL
from chrono.timezones.australia.brisbane import BRISBANE
from chrono.timezones.australia.lindeman import LINDEMAN
from chrono.timezones.australia.adelaide import ADELAIDE
from chrono.timezones.australia.darwin import DARWIN
from chrono.timezones.australia.perth import PERTH
from chrono.timezones.australia.eucla import EUCLA
from chrono.timezones.asia.tokyo import TOKYO


struct Australia(ImplicitlyCopyable, Movable):
    """Australia — ISO 3166-1 alpha-2 'AU'."""

    comptime CODE = StaticString("AU")
    comptime NAME = StaticString("Australia")
    comptime FLAG = StaticString("🇦🇺")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("en_AU")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[115, 5],
        Timezone[144, 7],
        Timezone[154, 4],
        Timezone[142, 4],
        Timezone[142, 4],
        Timezone[144, 6],
        Timezone[17, 4],
        Timezone[21, 4],
        Timezone[143, 5],
        Timezone[10, 5],
        Timezone[19, 4],
        Timezone[19, 4],
        Timezone[9, 4],
    ]:
        return (
            LORD_HOWE,
            MACQUARIE,
            HOBART,
            MELBOURNE,
            SYDNEY,
            BROKEN_HILL,
            BRISBANE,
            LINDEMAN,
            ADELAIDE,
            DARWIN,
            PERTH,
            EUCLA,
            TOKYO,
        )
