# 04 — Type signatures

> **Version:** 0.1.0 | **Updated:** 2026-06-16

The concrete shape of every public type. Signatures use the idioms verified in
[07-idioms](07-idioms.md): `def` only (no `fn`), explicit `__init__(out self,
…)`, `TrivialRegisterPassable` where the value fits in a register and
`(ImplicitlyCopyable, Movable)` where it carries an inline array, no tuples
(small structs instead), `StaticString` for names, `var self` plus `return
self^` for fluent builders.

---

## Representation decisions

| Type                                     | Internal storage                                                    | Why                                                                                                           |
| ---------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `Duration`                               | `Int64 seconds` + `UInt32 nanosecond` (0..<1e9, sign on seconds)    | java.time model — avoids the "two signs" bug; ±292 billion years, nanosecond precision.                       |
| `Date`                                   | `Int32 days_since_epoch`                                            | A date is an integer — compare / sort / step are integer ops; SIMD-friendly. Y/M/D computed on demand.        |
| `Time`                                   | `Int64 nanoseconds_since_midnight`                                  | A time is an integer — trivial compare.                                                                       |
| `DateTime`                               | `(Date, Time)`                                                      | The view = date ⊕ time.                                                                                       |
| `Instant[clock]`                         | `Duration since_epoch`                                              | A point = epoch + vector. `clock` is a comptime parameter so realtime / monotonic don't mix.                  |
| `Offset`                                 | `Int32 seconds` (east of UTC)                                       | Fits a register; absolute value capped at 18 hours (RFC 3339 §5.6 limit).                                     |
| `Timezone[transition_count, type_count]` | `InlineArray[Int64, N]` + `InlineArray[UInt8, N]` + 12 POSIX fields | Every offset transition + the POSIX-footer rule, inlined as comptime data. Carried by-array, not by-register. |

All scalar value types conform to `TrivialRegisterPassable` and live in
registers with no allocation. `Timezone[N, T]` is `(ImplicitlyCopyable,
Movable)` because of the inline arrays.

---

## `_core`

```mojo
# civil.mojo  [fn] — Hinnant's algorithms
def days_since_epoch_from_date(year: Int, month: Int, day: Int) -> Int
def date_from_days_since_epoch(days: Int) -> YearMonthDay      # small struct, NOT a tuple
def weekday_from_days_since_epoch(days: Int) -> Int            # 0=Sunday .. 6=Saturday
def iso_weekday_from_days_since_epoch(days: Int) -> Int        # 1=Monday .. 7=Sunday
def is_leap_year(year: Int) -> Bool
def days_in_month(year: Int, month: Int) -> Int

# clock_id.mojo  [enum]
struct ClockId(ImplicitlyCopyable, Movable, Equatable):
    var _value: Int32
    def __init__(out self, *, raw: Int32): ...      # internal, no validation
    def __init__(out self, value: Int32) raises    # validating: must be 0 or 1
    comptime REALTIME  = ClockId(raw=0)
    comptime MONOTONIC = ClockId(raw=1)

# clock.mojo  [group]
struct Clock:
    @staticmethod
    def now(clock: ClockId) raises -> Duration   # external_call["clock_gettime", ...]
```

`YearMonthDay` is a tiny value struct (`year: Int`, `month: Int`, `day: Int`)
replacing the tuple return that this Mojo toolchain rejects. It is public —
`from chrono import YearMonthDay`.

---

## `Duration` — affine vector

```mojo
struct Duration(TrivialRegisterPassable, Comparable):
    var _seconds: Int64          # whole seconds (sign here)
    var _nanosecond: UInt32      # sub-second part, 0..<1e9

    comptime ZERO = Duration(0, 0)
    @staticmethod
    def from_seconds(seconds: Int64) -> Self
    @staticmethod
    def from_milliseconds(milliseconds: Int64) -> Self
    @staticmethod
    def from_microseconds(microseconds: Int64) -> Self
    @staticmethod
    def from_nanoseconds(nanoseconds: Int64) -> Self
    @staticmethod
    def from_minutes(minutes: Int64) raises -> Self    # raise on i64 second overflow
    @staticmethod
    def from_hours(hours: Int64) raises -> Self
    @staticmethod
    def from_days(days: Int64) raises -> Self          # 1 day = exactly 86_400 s

    comptime MIN = Duration(Int64.MIN, 0)
    comptime MAX = Duration(Int64.MAX, UInt32(999_999_999))

    def total_seconds(self) -> Int64
    def total_milliseconds(self) -> Int64
    def total_microseconds(self) -> Int64
    def nanosecond(self) -> UInt32                # sub-second component
    def is_zero(self) -> Bool
    def is_negative(self) -> Bool

    def __add__(self, other: Self) -> Self
    def __sub__(self, other: Self) -> Self
    def __neg__(self) -> Self
    def __mul__(self, factor: Int) -> Self
    def __abs__(self) -> Self
    # Comparable: __lt__ __le__ __gt__ __ge__ __eq__ __ne__
```

---

## `Instant[clock]` — affine point

```mojo
struct Instant[clock: ClockId = ClockId.REALTIME](TrivialRegisterPassable, Comparable):
    var _since_epoch: Duration

    @staticmethod
    def unix_epoch() -> Self
    @staticmethod
    def now() raises -> Self                                   # Clock.now(clock)
    @staticmethod
    def from_seconds_since_epoch(seconds: Int64) -> Self
    @staticmethod
    def from_milliseconds_since_epoch(milliseconds: Int64) -> Self

    def since_epoch(self) -> Duration
    def seconds_since_epoch(self) -> Int64
    def milliseconds_since_epoch(self) -> Int64

    def __sub__(self, other: Self) -> Duration                 # point − point = vector (same clock)
    def __add__(self, duration: Duration) -> Self
    def __sub__(self, duration: Duration) -> Self
```

`Instant[REALTIME] − Instant[MONOTONIC]` does not type-check — a compile
error, by design. Monotonic readings come from
`Instant[ClockId.MONOTONIC].now()`.

---

## `Weekday` and `Month`

```mojo
struct Weekday(ImplicitlyCopyable, Movable, Equatable):
    var _value: UInt8
    def __init__(out self, *, raw: UInt8): ...           # internal, no validation
    def __init__(out self, value: UInt8) raises          # validating: must be 1..7
    comptime MONDAY = Weekday(raw=1)        # ... SUNDAY = Weekday(raw=7)
    def iso_number(self) -> Int             # Monday=1 .. Sunday=7
    def name(self) -> StaticString

struct Month(ImplicitlyCopyable, Movable, Equatable):
    var _value: UInt8
    def __init__(out self, *, raw: UInt8): ...           # internal, no validation
    def __init__(out self, value: UInt8) raises          # validating: must be 1..12
    comptime JANUARY = Month(raw=1)         # ... DECEMBER = Month(raw=12)
    def number(self) -> Int                 # 1..12
    def name(self) -> StaticString
```

The English month and weekday vocabulary lives in `name()` of these two enums.
`Strftime` and `NaturalDate` read from them — there is no `Locale` type.

---

## `Date`, `Time`, `DateTime` — naive civil view

```mojo
struct Date(TrivialRegisterPassable, Comparable):
    var _days_since_epoch: Int32

    def __init__(out self, year: Int, month: Int, day: Int) raises   # validates
    @staticmethod
    def from_days_since_epoch(days: Int) raises -> Self

    def year(self) -> Int
    def month(self) -> Month
    def day(self) -> Int
    def year_month_day(self) -> YearMonthDay          # one decode for all three
    def weekday(self) -> Weekday
    def day_of_year(self) -> Int
    def is_leap_year(self) -> Bool
    def days_since_epoch(self) -> Int

    def plus_days(self, days: Int) raises -> Self
    def minus_days(self, days: Int) raises -> Self
    def __sub__(self, other: Self) -> Int             # number of days between dates

struct Time(TrivialRegisterPassable, Comparable):
    var _nanoseconds_since_midnight: Int64

    def __init__(out self, hour: Int, minute: Int, second: Int = 0, nanosecond: Int = 0) raises
    comptime MIDNIGHT = Time(0)
    @staticmethod
    def from_nanoseconds_since_midnight(nanoseconds: Int64) raises -> Self

    def hour(self) -> Int
    def minute(self) -> Int
    def second(self) -> Int
    def nanosecond(self) -> Int
    def nanoseconds_since_midnight(self) -> Int64

struct DateTime(TrivialRegisterPassable, Comparable):
    var _date: Date
    var _time: Time

    def __init__(out self, year: Int, month: Int, day: Int,
                 hour: Int = 0, minute: Int = 0, second: Int = 0, nanosecond: Int = 0) raises
    @staticmethod
    def combine(date: Date, time: Time) -> Self
    @staticmethod
    def from_utc_instant(instant: Instant) -> Self
    def to_utc_instant(self) -> Instant

    def date(self) -> Date
    def time(self) -> Time
    def year(self) -> Int        # ... month()/day()/hour()/minute()/second()/nanosecond()
    def weekday(self) -> Weekday

    def __add__(self, duration: Duration) -> Self     # exact wall arithmetic (naive, no DST)
    def __sub__(self, duration: Duration) -> Self
    def __sub__(self, other: Self) -> Duration
    def plus_span(self, span: Span) raises -> Self    # calendar arithmetic (months/years), clamps
```

---

## `Now` and `Offset`

```mojo
# now.mojo  [group] — civil "now" through the UTC lens; for a zoned now use
# ZonedDateTime.now(<typed Timezone constant>).
struct Now:
    @staticmethod
    def utc_datetime() raises -> DateTime    # = DateTime.from_utc_instant(Instant.now())
    @staticmethod
    def utc_date() raises -> Date
    @staticmethod
    def utc_time() raises -> Time

# offset.mojo  [value] — fixed UTC offset. Full IANA zone semantics live in
# the typed `Timezone[N, T]` (see timezone.mojo + timezones/<area>/<location>.mojo).
struct Offset(TrivialRegisterPassable, Comparable):
    var _seconds: Int32                      # seconds east of UTC (+07:00 -> +25200)
    comptime UTC = Offset(total_seconds=0)
    def __init__(out self, *, total_seconds: Int32)                # internal
    def __init__(out self, hours: Int, minutes: Int = 0) raises    # |offset| <= 18:00
    @staticmethod
    def from_seconds(seconds: Int) raises -> Self
    def total_seconds(self) -> Int
    def is_utc(self) -> Bool
```

---

## `Rfc3339` and `Strftime` — symmetric serialization

```mojo
# format/rfc3339.mojo  [group]
struct Rfc3339:
    @staticmethod
    def format(datetime: DateTime, offset: Offset) raises -> String
    @staticmethod
    def format(offset_datetime: OffsetDateTime) raises -> String
    @staticmethod
    def parse(text: String) raises -> OffsetDateTime               # absolute moment + its offset
    @staticmethod
    def parse_to_instant(text: String) raises -> Instant[ClockId.REALTIME]

# format/strftime.mojo  [group] — same C89 directive set both ways
# (`%Y %y %m %d %H %I %M %S %j %p %A %a %B %b %%`); English / C locale only.
struct Strftime:
    @staticmethod
    def format(datetime: DateTime, pattern: String) raises -> String
    @staticmethod
    def parse(text: String, pattern: String) raises -> DateTime
```

`parse` accepts every `format` directive except `%j` (day-of-year would
require a multi-pass parser to recover month + day from year). Missing fields
default to the Unix epoch. Conflict resolution is last-write-wins; `%I` + `%p`
combine to 24-hour. `%y` pivot follows RFC 5280 §4.1.2.5.1: `00..49 → 20YY`,
`50..99 → 19YY`.

`OffsetDateTime` is what `Rfc3339.parse` returns — a value type carrying the
absolute moment plus its UTC offset. No `ParsedTimestamp` intermediate.

---

## `DateTimeBuilder`

```mojo
# builder.mojo  [builder] — fluent via `var self`; scope is the naive DateTime
# fields (a zoned builder is via ZonedDateTime.from_local + a typed Timezone constant).
struct DateTimeBuilder(ImplicitlyCopyable, Movable):
    def __init__(out self)                                          # epoch defaults
    def year(var self, year: Int) -> Self                           # chains: .year(2026).month(6)...
    def month(var self, month: Int) -> Self
    def day(var self, day: Int) -> Self
    def hour(var self, hour: Int) -> Self
    def minute(var self, minute: Int) -> Self
    def second(var self, second: Int) -> Self
    def nanosecond(var self, nanosecond: Int) -> Self
    def build(self) raises -> DateTime                              # validates here
```

---

## `Timezone[N, T]` — the typed IANA zone

```mojo
struct Timezone[transition_count: Int, type_count: Int](
    ImplicitlyCopyable, Movable
):
    var name: StaticString       # "Asia/Ho_Chi_Minh"
    var area: StaticString       # "Asia"
    var location: StaticString   # "Ho_Chi_Minh"
    var continent: Continent

    var transitions: InlineArray[Int64, Self.transition_count]
    var type_indices: InlineArray[UInt8, Self.transition_count]
    var offsets: InlineArray[Int32, Self.type_count]
    var is_dst: InlineArray[UInt8, Self.type_count]

    # POSIX-footer rule — governs instants past the final transition.
    var posix_has_rule: Bool
    var posix_has_dst: Bool
    var posix_std_offset: Int32
    var posix_dst_offset: Int32
    var posix_start_month: Int32 ; var posix_start_week: Int32
    var posix_start_day:   Int32 ; var posix_start_time: Int32
    var posix_end_month:   Int32 ; var posix_end_week:   Int32
    var posix_end_day:     Int32 ; var posix_end_time:   Int32

    def offset_at(self, epoch_seconds: Int64) -> Int32
    def local_lookup(self, local_seconds: Int64, fold: Bool) -> Int32
```

Each IANA zone lives in its own file under
`chrono/timezones/<area>/<location>.mojo` as a single `comptime` constant;
users import the constant directly (`from chrono.timezones.asia.bangkok import
BANGKOK`).

---

## `ZonedDateTime` — parametric over the typed zone

```mojo
struct ZonedDateTime(Copyable, Movable):
    var _local: DateTime
    var _offset: Offset
    var _zone_name: String

    @staticmethod
    def from_instant[N: Int, T: Int](
        instant: Instant[ClockId.REALTIME],
        timezone: Timezone[N, T],
    ) raises -> Self

    @staticmethod
    def from_local[N: Int, T: Int](
        local: DateTime,
        timezone: Timezone[N, T],
        fold: Bool = False,             # PEP 495 disambiguation at DST seams
    ) raises -> Self

    @staticmethod
    def now[N: Int, T: Int](timezone: Timezone[N, T]) raises -> Self

    def to_instant(self) -> Instant[ClockId.REALTIME]
    def datetime(self) -> DateTime ; def date(self) -> Date ; def time(self) -> Time
    def offset(self) -> Offset ; def zone_name(self) -> String
    def year(self) -> Int ; def month(self) -> Month ; def day(self) -> Int
    def hour(self) -> Int ; def minute(self) -> Int ; def second(self) -> Int
    def nanosecond(self) -> Int ; def weekday(self) -> Weekday
    # Comparable by absolute instant: __lt__ __le__ __gt__ __ge__ __eq__ __ne__
```

`ZonedDateTime` carries the resolved offset + the zone NAME as fields; the
typed `Timezone[N, T]` is parametric INPUT to the static constructors, not a
stored field. That keeps the struct itself shape-stable across zones with
wildly different `N` and `T`.

---

## Conventions in force

| Convention  | Detail                                                                                                                                                |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| Operators   | Only for the affine algebra (`Duration` / `Instant` / `DateTime` / `ZonedDateTime`). Calendar stepping uses named methods (`plus_days`, `plus_span`). |
| "Now" homes | `Instant.now()` for the absolute instant; `Now.utc_*()` for the civil UTC projections; `ZonedDateTime.now(timezone)` for the zoned projection.        |
| Errors      | Constructors validate and raise; never silently clamp. Every parser carries the offending value plus the valid range in its error.                    |
