# Continent — the top of chrono's geographic hierarchy. Every country belongs to
# exactly one continent; every IANA zone's area maps to one continent. The 7-value
# enum is comptime-folded — `Continent.ASIA` is a single tag at the call site,
# zero runtime cost.
#
# The continent boundary follows IANA's tz `Area/` naming, not strict geography.
# AMERICAS rolls up North + South America + Caribbean + Central America (the
# America/ area, plus Atlantic/Bermuda etc.). The Atlantic/, Indian/, and Pacific/
# areas in IANA hold zones with no continent of their own — they're attached
# here to the nearest landmass per-zone (e.g. Atlantic/Reykjavik -> EUROPE,
# Indian/Maldives -> ASIA, Pacific/Auckland -> OCEANIA), so the exact AMERICAS
# / OCEANIA membership is driven by the per-zone `continent=` argument, not by
# the IANA area name alone.
#
# Facets: tier T1 (geography) | safety sound (validating ctor rejects out-of-range) | quantum n/a.
# Honesty: from spec (IANA tz `Area/` naming + zone1970.tab country attachments);
# the per-zone Continent argument is the source of truth for ambiguous Atlantic /
# Indian / Pacific island states.

from std.collections.inline_array import InlineArray


comptime _CONTINENT_NAMES: InlineArray[StaticString, 7] = [
    "Asia",
    "Europe",
    "Americas",
    "Africa",
    "Oceania",
    "Antarctica",
    "Etc",
]


struct Continent(Equatable, ImplicitlyCopyable, Movable):
    """One of the seven IANA-area-derived continents."""

    var _value: UInt8

    @always_inline
    def __init__(out self, *, raw: UInt8):
        """Internal: skip validation. Callers must guarantee `raw` in 1..7."""
        self._value = raw

    @always_inline
    def __init__(out self, value: UInt8) raises:
        """Validating: rejects `value` outside the 1..7 enum range."""
        if value < 1 or value > 7:
            raise Error(
                "chrono.Continent: value must be 1..7, got "
                + String(Int(value))
            )
        self._value = value

    comptime ASIA = Continent(raw=1)
    comptime EUROPE = Continent(raw=2)
    comptime AMERICAS = Continent(raw=3)  # Americas + Caribbean + some Atlantic
    comptime AFRICA = Continent(raw=4)
    # Oceania: Australia + Pacific (Indian island states map per-zone, see header).
    comptime OCEANIA = Continent(raw=5)
    comptime ANTARCTICA = Continent(raw=6)
    comptime ETC = Continent(raw=7)  # Etc/UTC, Etc/GMT*, the fixed-offset zones

    @always_inline
    def name(self) -> StaticString:
        return _CONTINENT_NAMES[Int(self._value) - 1]

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._value == other._value

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return self._value != other._value
