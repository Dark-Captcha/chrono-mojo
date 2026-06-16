# Heard Island & McDonald Islands — ISO 3166-1 alpha-2 "HM". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent


struct HeardIslandMcdonaldIslands(ImplicitlyCopyable, Movable):
    """Heard Island & McDonald Islands — ISO 3166-1 alpha-2 'HM'."""

    comptime CODE = StaticString("HM")
    comptime NAME = StaticString("Heard Island & McDonald Islands")
    comptime FLAG = StaticString("🇭🇲")
    comptime CONTINENT = Continent.OCEANIA
    comptime LOCALES = StaticString("")

    @staticmethod
    @always_inline
    def zones() -> Tuple[]:
        return Tuple[]()
