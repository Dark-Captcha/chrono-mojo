# ZonedDateTime — an absolute moment presented in a named IANA time zone: it carries
# the local wall-clock fields, the UTC offset in force at that moment (so it is
# DST-correct), and the zone name. Built from an Instant + typed Timezone[N, T], or
# from local wall-clock fields with PEP 495 fold/gap disambiguation at DST seams.
# Compares by the absolute instant.
#
# Presentation type by design: ZonedDateTime stores the *resolved* offset and the
# zone name (a `StaticString`), not the parametric `Timezone[N, T]`. That keeps the
# struct shape stable across zones, but it also means ZonedDateTime cannot project
# a new instant on its own — for arithmetic, do
#
#     ZonedDateTime.from_instant(zoned.to_instant() + duration, ZONE)
#
# i.e. step on the absolute timeline (`Instant`/`Duration`), then re-project. That
# explicit re-project is the whole reason this type is shaped this way: a `+ Duration`
# operator would have to choose between dropping the zone (changing the type to
# `OffsetDateTime`) or silently sticking to a stale offset across a DST seam. Neither
# is correct, so neither is offered.
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: from_instant pulls the offset from the comptime-baked Timezone
# (verified equivalent to Python `zoneinfo` on the test_timezone_typed vectors).
# from_local resolves wall-clock to offset via Timezone.local_lookup, KAT-pinned
# in test_zoned (fold + gap, both hemispheres, POSIX-future region).

from chrono.datetime import DateTime
from chrono.date import Date
from chrono.time import Time
from chrono.offset import Offset
from chrono.instant import Instant
from chrono._core.clock_id import ClockId
from chrono.duration import Duration
from chrono.enums import Weekday, Month
from chrono.timezone import Timezone


struct ZonedDateTime(Copyable, Movable):
    var _local: DateTime
    var _offset: Offset
    # The zone name is always sourced from `Timezone.name` (a comptime-baked
    # `StaticString`), so the field holds it directly — no heap allocation on
    # construction, no copy on every accessor.
    var _zone_name: StaticString

    def __init__(
        out self, local: DateTime, offset: Offset, zone_name: StaticString
    ):
        self._local = local
        self._offset = offset
        self._zone_name = zone_name

    @staticmethod
    def from_instant[
        transition_count: Int, type_count: Int
    ](
        instant: Instant[ClockId.REALTIME],
        timezone: Timezone[transition_count, type_count],
    ) raises -> Self:
        var offset = Offset.from_seconds(
            Int(timezone.offset_at(instant.seconds_since_epoch()))
        )
        var local = DateTime.from_utc_instant(
            instant + Duration.from_seconds(Int64(offset.total_seconds()))
        )
        return Self(local, offset, timezone.name)

    @staticmethod
    def from_local[
        transition_count: Int, type_count: Int
    ](
        local: DateTime,
        timezone: Timezone[transition_count, type_count],
        fold: Bool = False,
    ) raises -> Self:
        """Build a zoned moment from LOCAL wall-clock fields in `timezone`. At a DST
        gap or fold the local time is missing or ambiguous; `fold` disambiguates per
        PEP 495 (`fold=False` keeps the pre-transition offset, `fold=True` the
        post-transition one). The given fields are preserved; `to_instant()` returns
        `local - offset`."""
        var local_seconds = local.to_utc_instant().seconds_since_epoch()
        var offset = Offset.from_seconds(
            Int(timezone.local_lookup(local_seconds, fold))
        )
        return Self(local, offset, timezone.name)

    @staticmethod
    def now[
        transition_count: Int, type_count: Int
    ](timezone: Timezone[transition_count, type_count]) raises -> Self:
        return Self.from_instant(Instant.now(), timezone)

    @always_inline
    def to_instant(self) -> Instant[ClockId.REALTIME]:
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
    def zone_name(self) -> StaticString:
        return self._zone_name

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
