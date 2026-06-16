# OffsetDateTime — an absolute moment that also remembers the fixed UTC offset it
# was expressed in: = (local DateTime as seen at the offset, Offset). This is what
# RFC 3339 carries and what X.509 validity stores. It converts to/from an absolute
# Instant, and compares by that absolute instant (two offset-datetimes naming the
# same moment are equal, even with different offsets).
#
# A fixed offset is NOT a time zone: there are no DST rules here. For DST-correct
# projection through a named IANA zone, see `chrono.zoned_datetime.ZonedDateTime`
# (parametric over `Timezone[transition_count, type_count]`).
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: from spec; the instant conversion is verified differential vs Python
# datetime (aware timestamps).

from chrono.datetime import DateTime
from chrono.date import Date
from chrono.time import Time
from chrono.offset import Offset
from chrono.instant import Instant
from chrono._core.clock_id import ClockId
from chrono.duration import Duration
from chrono.enums import Weekday, Month


struct OffsetDateTime(Comparable, TrivialRegisterPassable):
    var _local: DateTime  # wall-clock fields as seen at `_offset`
    var _offset: Offset

    @always_inline
    def __init__(out self, datetime: DateTime, offset: Offset):
        self._local = datetime
        self._offset = offset

    @staticmethod
    def from_instant(
        instant: Instant[ClockId.REALTIME], offset: Offset
    ) raises -> Self:
        """The given absolute instant, expressed at `offset`."""
        var local = DateTime.from_utc_instant(
            instant + Duration.from_seconds(Int64(offset.total_seconds()))
        )
        return Self(local, offset)

    @always_inline
    def to_instant(self) -> Instant[ClockId.REALTIME]:
        """The absolute moment: the local fields, minus the offset, are UTC."""
        return self._local.to_utc_instant() - Duration.from_seconds(
            Int64(self._offset.total_seconds())
        )

    @always_inline
    def datetime(self) -> DateTime:
        return self._local

    @always_inline
    def offset(self) -> Offset:
        return self._offset

    @always_inline
    def date(self) -> Date:
        return self._local.date()

    @always_inline
    def time(self) -> Time:
        return self._local.time()

    @always_inline
    def year(self) -> Int:
        return self._local.year()

    @always_inline
    def month(self) -> Month:
        return self._local.month()

    @always_inline
    def day(self) -> Int:
        return self._local.day()

    @always_inline
    def hour(self) -> Int:
        return self._local.hour()

    @always_inline
    def minute(self) -> Int:
        return self._local.minute()

    @always_inline
    def second(self) -> Int:
        return self._local.second()

    @always_inline
    def nanosecond(self) -> Int:
        return self._local.nanosecond()

    @always_inline
    def weekday(self) -> Weekday:
        return self._local.weekday()

    # --- comparison by the absolute instant ---

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self.to_instant() == other.to_instant()

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return self.to_instant() != other.to_instant()

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        return self.to_instant() < other.to_instant()

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self.to_instant() <= other.to_instant()

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return self.to_instant() > other.to_instant()

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return self.to_instant() >= other.to_instant()
