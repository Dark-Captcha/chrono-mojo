# New Zealand — ISO 3166-1 alpha-2 "NZ". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.pacific.auckland import AUCKLAND
from chrono.timezones.pacific.chatham import CHATHAM


struct NewZealand(ImplicitlyCopyable, Movable):
    """New Zealand — ISO 3166-1 alpha-2 'NZ'."""

    comptime CODE = StaticString("NZ")
    comptime NAME = StaticString("New Zealand")
    comptime FLAG = StaticString("🇳🇿")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("en_NZ|mi_NZ|niu_NZ")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[156, 7], Timezone[129, 5]]:
        return (AUCKLAND, CHATHAM)
