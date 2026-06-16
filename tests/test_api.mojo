# Smoke test of the public package surface: every name re-exported from
# `chrono/__init__.mojo` is reachable via `from chrono import X` and the common
# composition (DateTime -> arithmetic -> RFC 3339) works end-to-end. Listing every
# re-export here means a removed name breaks this test, locking the API surface.

from chrono import (
    # value types + clock
    Duration,
    Instant,
    ClockId,
    YearMonthDay,
    Weekday,
    Month,
    Date,
    Time,
    DateTime,
    DateTimeBuilder,
    Span,
    YearMonth,
    MonthDay,
    Now,
    Offset,
    OffsetDateTime,
    ZonedDateTime,
    # calendars
    iso_week_date,
    easter,
    IsoWeekDate,
    Calendar,
    GregorianCalendar,
    JulianCalendar,
    IslamicCalendar,
    # serialization formats
    Rfc3339,
    Asn1Time,
    Strftime,
    Rfc2822,
    HttpDate,
    IsoDuration,
    IsoDurationValue,
    # recurrence + natural
    RecurrenceRule,
    Frequency,
    WeekdayRule,
    NaturalDate,
    TimeUnit,
    # typed timezone layer
    Continent,
    Timezone,
)
from chrono.timezones.etc.utc import UTC


def run() raises -> Int:
    var f = 0

    var moment = DateTime(2026, 6, 15, 14, 30, 0)
    var later = moment + Duration.from_hours(3)
    if Rfc3339.format(later, Offset.UTC) != "2026-06-15T17:30:00Z":
        print("FAIL public compose / format")
        f += 1

    var instant = Rfc3339.parse_to_instant("2026-06-15T14:30:00+07:00")
    if instant.seconds_since_epoch() != 1781508600:  # 07:30 UTC
        print("FAIL public parse_to_instant", instant.seconds_since_epoch())
        f += 1

    if Weekday.MONDAY.iso_number() != 1 or Month.JUNE.number() != 6:
        print("FAIL public enums")
        f += 1

    # Every other re-export is exercised below — calling a constructor or a
    # method ensures the name is not just imported but actually wired through.
    _ = Now.utc_datetime()
    _ = Date(2026, 1, 1)
    _ = Time(0, 0, 0)
    _ = Instant.unix_epoch()
    _ = ClockId.MONOTONIC
    var ymd = Date(2026, 1, 1).year_month_day()
    _ = YearMonthDay(ymd.year, ymd.month, ymd.day)
    _ = DateTimeBuilder()
    _ = Span(days=1)
    _ = YearMonth(2026, 6)
    _ = MonthDay(6, 15)
    _ = OffsetDateTime(moment, Offset.UTC)
    _ = iso_week_date(Date(2026, 1, 1))
    _ = easter(2026)
    _ = IsoWeekDate(2026, 1, Weekday.MONDAY.iso_number())
    # Calendar implementations are stateless; calling a static method also
    # exercises the trait-conforming `Calendar`.
    _ = GregorianCalendar.days_since_epoch(2026, 1, 1)
    _ = JulianCalendar.days_since_epoch(2026, 1, 1)
    _ = IslamicCalendar.days_since_epoch(1447, 1, 1)
    _ = Strftime.format(moment, "%Y")
    _ = Asn1Time.format_utc_time(moment)
    _ = Rfc2822.format(OffsetDateTime(moment, Offset.UTC))
    _ = HttpDate.format(moment)
    _ = IsoDuration.format(Span(days=1), Duration.ZERO)
    _ = IsoDurationValue(Span(days=1), Duration.ZERO)
    _ = RecurrenceRule.parse("FREQ=DAILY;COUNT=1")
    _ = Frequency.DAILY
    _ = WeekdayRule(Weekday.MONDAY, 0)
    _ = NaturalDate.parse("now", moment)
    _ = TimeUnit.DAY
    _ = Continent.ASIA
    # Exercise the parametric `Timezone` type + `ZonedDateTime` through a typed
    # constant so removing either re-export breaks the suite.
    var zoned_now = ZonedDateTime.now(UTC)
    if zoned_now.offset().total_seconds() != 0:
        print("FAIL ZonedDateTime.now(UTC) offset != 0")
        f += 1

    if f == 0:
        print("test_api: PASS")
    return f
