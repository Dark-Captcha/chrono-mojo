# Paraguay — ISO 3166-1 alpha-2 "PY". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.asuncion import ASUNCION


struct Paraguay(ImplicitlyCopyable, Movable):
    """Paraguay — ISO 3166-1 alpha-2 'PY'."""

    comptime CODE = StaticString("PY")
    comptime NAME = StaticString("Paraguay")
    comptime FLAG = StaticString("🇵🇾")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("es_PY")

    @staticmethod
    @always_inline
    def zones() -> Tuple[Timezone[104, 5]]:
        return (ASUNCION,)
