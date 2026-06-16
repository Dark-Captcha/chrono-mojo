# chrono-mojo

> **Version:** 0.1.0 | **Updated:** 2026-06-16
> **Package:** `chrono`

The standard date / time / timezone library for Mojo — pure-Mojo, zero runtime
dependency, the calendar counterpart to `std.time`'s stopwatch.

---

## Status

| Component              | State                                                                                                                                       |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| Calendar spine         | `Duration`, `Instant[clock]`, `Date`, `Time`, `DateTime`, `Span`, `Offset`                                                                  |
| Serialization formats  | RFC 3339, RFC 2822, HTTP-date, ASN.1 (UTCTime + GeneralizedTime), strftime, ISO-8601 duration                                               |
| Typed IANA timezones   | 524 zones + 252 backward-compat aliases (`tzdata 2026b`)                                                                                    |
| ISO 3166 countries     | 249 typed countries with `zones()` returning a typed `Tuple[Timezone[...], ...]`                                                            |
| Recurrence             | RFC 5545 RRULE (`FREQ`, `INTERVAL`, `COUNT`, `UNTIL`, `BYMONTH`, `BYMONTHDAY`, `BYDAY`, `WKST`)                                             |
| Calendar systems       | Gregorian, Julian, tabular Islamic (via the `Calendar` trait + epoch-day pivot)                                                             |
| Natural-language parse | English, seven bounded forms: `now`, `today`, `tomorrow`, `yesterday`, `in N <unit>`, `<N> <unit> ago`, `next <weekday>` / `last <weekday>` |
| SIMD batch layer       | `_core/civil_batch` — columnar day to civil, bit-identical to the scalar core                                                               |
| Test suites            | 26 green, zero warnings, `mblack` clean                                                                                                     |
| Toolchain              | `mojo-compiler 1.0.0b3.dev2026061606`, `mblack 26.5.0.dev2026061606`                                                                        |

---

## Why this exists

Mojo's stdlib ships `std.time` — `clock_gettime`, monotonic, `sleep` — a stopwatch.
There is no `datetime`, no time zones, no formatting. `chrono` fills that gap
and aims to be the canonical, reference-quality time library the Mojo ecosystem
builds on: `crypto-mojo` (X.509 `notBefore` / `notAfter`, JWT `exp` / `iat`),
`tls-mojo`, and `http-client-mojo` all need correct dates, instants, and the
wire formats.

---

## Design pillars

| Pillar                    | What it means                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Correct first             | Built from spec (RFC, ISO, POSIX, IANA), understood and re-implemented — never copied from a library.                                                                                                                                                                                                                                                                                                                                  |
| Zero runtime data         | Wall-clock via libc `clock_gettime` FFI. Every IANA zone is a `comptime` constant inside the compiled binary — no `/usr/share/zoneinfo` lookup, no data file to install, no parse cost at startup.                                                                                                                                                                                                                                     |
| Type-safe by construction | `Instant[clock]` separates monotonic from realtime at the type level. `ZonedDateTime` is parametric over `Timezone[transition_count, type_count]`, so the zone's shape is known at every use site.                                                                                                                                                                                                                                     |
| Fast                      | Scalar value types are `TrivialRegisterPassable` — `Duration`, `Instant`, `Date`, `Time`, `DateTime`, `Offset` live in registers, no allocation. `Timezone[N, T]` carries `InlineArray` transition tables so it's `ImplicitlyCopyable, Movable` — still `comptime`-baked, just not register-sized. SIMD batch path lowers to AVX-512 on capable CPUs through generic `SIMD[T, W]` — no hand-written intrinsics, no portability burden. |

---

## Quick start

Install the toolchain and run the test suite:

```bash
pixi install
pixi run test
```

Compose a moment, format it, parse it, project it into a typed zone:

```mojo
from chrono import Now, DateTime, Duration, Offset, Rfc3339, ZonedDateTime
from chrono.timezones.asia.ho_chi_minh import HO_CHI_MINH
from chrono.countries.asia.vietnam import Vietnam


def main() raises:
    # build a civil moment, shift it by an exact Duration, format to RFC 3339
    var moment = DateTime(2026, 6, 16, 10, 10, 0)
    var later = moment + Duration.from_hours(3)
    print(Rfc3339.format(later, Offset.UTC))               # 2026-06-16T13:10:00Z

    # parse a wire timestamp -> absolute Instant
    var parsed = Rfc3339.parse_to_instant("2026-06-16T10:10:00+07:00")

    # project the Instant into a typed IANA zone (zero runtime I/O, zero parse cost)
    var saigon = ZonedDateTime.from_instant(parsed, HO_CHI_MINH)
    print(saigon.hour(), saigon.offset().total_seconds())  # 10 25200

    # typed-country metadata + the country's IANA zone tuple
    print(Vietnam.NAME, Vietnam.zones()[1].name)           # Vietnam Asia/Ho_Chi_Minh

    # current wall-clock moment via libc clock_gettime (values vary per run)
    var current_utc = Now.utc_datetime()
    var current_saigon = ZonedDateTime.now(HO_CHI_MINH)
    print(Rfc3339.format(current_utc, Offset.UTC))
    print(current_saigon.hour(), current_saigon.offset().total_seconds())
```

---

## Public surface

| Family           | Exports                                                                                                             |
| ---------------- | ------------------------------------------------------------------------------------------------------------------- |
| Atomic values    | `Duration`, `Instant`, `ClockId`, `YearMonthDay`, `Weekday`, `Month`, `Date`, `Time`, `DateTime`                    |
| Composite values | `Span`, `YearMonth`, `MonthDay`, `Offset`, `OffsetDateTime`, `ZonedDateTime`                                        |
| Helpers          | `Now` (namespace for civil-UTC "now"), `DateTimeBuilder` (fluent assembly)                                          |
| Calendars        | `iso_week_date`, `easter`, `IsoWeekDate`, `Calendar`, `GregorianCalendar`, `JulianCalendar`, `IslamicCalendar`      |
| Formats          | `Rfc3339`, `Asn1Time`, `Strftime`, `Rfc2822`, `HttpDate`, `IsoDuration`, `IsoDurationValue`                         |
| Recurrence       | `RecurrenceRule`, `Frequency`, `WeekdayRule`                                                                        |
| Natural          | `NaturalDate`, `TimeUnit`                                                                                           |
| Typed zone       | `Continent`, `Timezone` (struct type; individual zone constants imported from `chrono.timezones.<area>.<location>`) |

---

## Documentation

| Document                                      | Subject                                                          |
| --------------------------------------------- | ---------------------------------------------------------------- |
| [01-purpose.md](docs/01-purpose.md)           | Purpose, user-facing surface, build order, deliberate boundaries |
| [02-principles.md](docs/02-principles.md)     | First-principles model of time (affine, projection, layers)      |
| [03-architecture.md](docs/03-architecture.md) | Module tree, unit kinds, dependency rule, typed timezone layout  |
| [04-types.md](docs/04-types.md)               | Type signatures and representation decisions                     |
| [05-naming.md](docs/05-naming.md)             | Naming rules and canonical lexicon                               |
| [06-foundations.md](docs/06-foundations.md)   | Standards bodies, data sources, algorithms, prior libraries      |
| [07-idioms.md](docs/07-idioms.md)             | Mojo `1.0.0b3` idioms used across the library                    |

Build order and version history live in [ROADMAP.md](ROADMAP.md).

---

## Verification discipline

| Layer        | Check                                                                                                                                                                                          |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Per-variant  | Known-answer tests for every supported input form (vectors pinned in `tests/`).                                                                                                                |
| Differential | At vector-generation time the typed-zone + typed-country tables were diffed against Python `zoneinfo` / `datetime` / `dateutil`; the resulting KAT vectors are frozen into the `tests/` suite. |
| Seam         | `tests/test_api.mojo` imports every public re-export and exercises a constructor or method, so removing a name from the public surface fails the suite.                                        |

Errors raise — no silent fallback, no return-of-default — and every parser
carries the offending value in its error message. Each Mojo language idiom is
used consistently across the library, documented in [07-idioms.md](docs/07-idioms.md).

---

## Deliberate boundaries

| Area                     | Decision                                                                                                                                                                                                                                                                                                                      |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Localization             | English (C / POSIX) only; `Strftime` and `NaturalDate` take month and weekday names from the `Weekday` / `Month` enums. No `Locale` type, no CLDR bundle.                                                                                                                                                                     |
| Leap seconds             | The Unix timeline ignores leap seconds in arithmetic. `:60` is parsed only at `23:59 UTC` (RFC 3339 §5.6) and folded to `:59`; elsewhere it raises. ASN.1 DER rejects `:60` outright per X.690 §11.7.                                                                                                                         |
| String-keyed zone lookup | Removed. Mojo's compiler cannot digest a 776-arm string dispatch over distinct parametric `Timezone[N, T]` instantiations in reasonable time; users import the zone constant directly (e.g. `from chrono.timezones.asia.bangkok import BANGKOK`). Backward-compat IANA names are re-exported from `chrono.timezones.aliases`. |
| Calendar scope           | Proleptic Gregorian for the core, plus Julian and tabular Islamic via the `Calendar` trait. Other calendars deferred.                                                                                                                                                                                                         |
| Platform                 | Linux-first for the libc clock. Timezone data is generated into typed Mojo constants at build time, so the library has no runtime `/usr/share/zoneinfo` dependency on any platform.                                                                                                                                           |
