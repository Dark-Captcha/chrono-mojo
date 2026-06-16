# DateTime — a naive civil date-time (the *view* = Date (+) Time), with no time zone.
# It projects to/from an absolute Instant by interpreting its fields as UTC, and
# supports exact arithmetic with Duration (naive: no DST, since there is no zone).
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: from spec; the Instant projection is verified differential vs Python
# `datetime` (UTC timestamps), arithmetic + round-trip by property/KAT.

from chrono.date import Date
from chrono.time import Time
from chrono.duration import Duration
from chrono.instant import Instant
from chrono._core.clock_id import ClockId
from chrono.enums import Weekday, Month
from chrono.span import Span

from chrono._core.units import SECONDS_PER_DAY, NANOS_PER_SECOND


struct DateTime(Comparable, TrivialRegisterPassable):
    var _date: Date
    var _time: Time

    @always_inline
    def __init__(out self, *, date: Date, time: Time):
        self._date = date
        self._time = time

    def __init__(
        out self,
        year: Int,
        month: Int,
        day: Int,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0,
    ) raises:
        self._date = Date(year, month, day)
        self._time = Time(hour, minute, second, nanosecond)

    @staticmethod
    @always_inline
    def combine(date: Date, time: Time) -> Self:
        return Self(date=date, time=time)

    @always_inline
    def _duration_since_epoch(self) -> Duration:
        """The naive datetime as a Duration since the epoch, treated as UTC."""
        return Duration.from_seconds(
            Int64(self._date.days_since_epoch()) * SECONDS_PER_DAY
        ) + Duration.from_nanoseconds(self._time.nanoseconds_since_midnight())

    @staticmethod
    def from_utc_instant(instant: Instant[ClockId.REALTIME]) raises -> Self:
        var since = instant.since_epoch()
        var seconds = since.total_seconds()  # floor
        var nanosecond = Int64(since.nanosecond())  # 0..<1e9
        var day = seconds // SECONDS_PER_DAY  # floor -> epoch day
        var second_of_day = seconds % SECONDS_PER_DAY  # 0..86399
        return Self(
            date=Date.from_days_since_epoch(Int(day)),
            time=Time(
                nanoseconds_since_midnight=second_of_day * NANOS_PER_SECOND
                + nanosecond
            ),
        )

    @always_inline
    def to_utc_instant(self) -> Instant[ClockId.REALTIME]:
        return Instant(self._duration_since_epoch())

    # --- field accessors (delegate to Date / Time) ---

    @always_inline
    def date(self) -> Date:
        return self._date

    @always_inline
    def time(self) -> Time:
        return self._time

    @always_inline
    def year(self) -> Int:
        return self._date.year()

    @always_inline
    def month(self) -> Month:
        return self._date.month()

    @always_inline
    def day(self) -> Int:
        return self._date.day()

    @always_inline
    def hour(self) -> Int:
        return self._time.hour()

    @always_inline
    def minute(self) -> Int:
        return self._time.minute()

    @always_inline
    def second(self) -> Int:
        return self._time.second()

    @always_inline
    def nanosecond(self) -> Int:
        return self._time.nanosecond()

    @always_inline
    def weekday(self) -> Weekday:
        return self._date.weekday()

    # --- exact arithmetic (naive; ignores DST because there is no zone) ---

    def __add__(self, duration: Duration) raises -> Self:
        return Self.from_utc_instant(
            Instant(self._duration_since_epoch() + duration)
        )

    def __sub__(self, duration: Duration) raises -> Self:
        return Self.from_utc_instant(
            Instant(self._duration_since_epoch() - duration)
        )

    @always_inline
    def __sub__(self, other: Self) -> Duration:
        return self._duration_since_epoch() - other._duration_since_epoch()

    def plus_span(self, span: Span) raises -> Self:
        """Calendar arithmetic on the date part (clamped); the time of day is kept."""
        return Self.combine(self._date.plus_span(span), self._time)

    def minus_span(self, span: Span) raises -> Self:
        return Self.combine(self._date.minus_span(span), self._time)

    # --- comparison (lexicographic on date then time) ---

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self._date == other._date and self._time == other._time

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)

    @always_inline
    def __lt__(self, other: Self) -> Bool:
        if self._date != other._date:
            return self._date < other._date
        return self._time < other._time

    @always_inline
    def __le__(self, other: Self) -> Bool:
        return self < other or self == other

    @always_inline
    def __gt__(self, other: Self) -> Bool:
        return not (self <= other)

    @always_inline
    def __ge__(self, other: Self) -> Bool:
        return not (self < other)
