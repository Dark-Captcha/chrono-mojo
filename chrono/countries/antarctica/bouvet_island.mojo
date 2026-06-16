# Bouvet Island — ISO 3166-1 alpha-2 "BV". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent


struct BouvetIsland(ImplicitlyCopyable, Movable):
    """Bouvet Island — ISO 3166-1 alpha-2 'BV'."""

    comptime CODE = StaticString("BV")
    comptime NAME = StaticString("Bouvet Island")
    comptime FLAG = StaticString("🇧🇻")
    comptime CONTINENT = Continent.ANTARCTICA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[]:
        return Tuple[]()
