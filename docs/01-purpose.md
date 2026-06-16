# 01 — Purpose & Scope

> **Version:** 0.1.0 | **Updated:** 2026-06-16

What `chrono` is for, what it covers, and what is deliberately out of scope.

---

## Purpose

`chrono` is a pure-Mojo, zero-dependency **date / time / timezone** library — the
calendar counterpart to `std.time`'s stopwatch. The goal is to be the standard,
reference-quality time library of the Mojo ecosystem: correct first, a friendly
canonical API (stdlib-style so it can slot into `std` later), built from spec
(understood and re-implemented, never ported), usable with no setup. Wall-clock
comes from libc `clock_gettime` via FFI; every IANA zone is a `comptime`
constant inside the compiled binary, so there is no `/usr/share/zoneinfo`
lookup and no data file to install. It is the shared time dependency for
`crypto-mojo` (X.509 `notBefore` / `notAfter`, JWT `exp` / `iat`), `tls-mojo`,
and `http-client-mojo`.

---

## User-facing capabilities

| Capability             | What it covers                                                                                                                                                                                                                       |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Know "now"             | Current instant, today's date, current weekday, current civil UTC datetime. Zoned "now" via `ZonedDateTime.now(<typed Timezone constant>)`.                                                                                          |
| Measure and span       | Monotonic duration of an operation; the gap between two `Instant`s ("how long ago", "how much longer"). Calendar `Span` for `+1 month` / `+1 year` with end-of-month clamping.                                                       |
| Calendar dates         | Construct, read, and validate `Date` / `Time` / `DateTime`. Add or subtract exact `Duration`s. Quick questions: leap year, days in month, ISO week, day-of-year, weekday.                                                            |
| Time zones             | Convert local ↔ UTC, render an `Instant` through a named IANA zone, add time across a DST boundary, look up the offset at any historical instant. Each zone is imported directly: `from chrono.timezones.asia.tokyo import TOKYO`.   |
| Wire-format read/write | RFC 3339 (JSON / API timestamps), RFC 2822 + RFC 7231 HTTP-date, ASN.1 UTCTime + GeneralizedTime (X.509 validity), strftime (`format` + `parse`, English / C locale), ISO 8601 duration (strict canonical-order parse + round-trip). |
| Recurrence             | RFC 5545 RRULE — FREQ DAILY/WEEKLY/MONTHLY/YEARLY + INTERVAL + COUNT/UNTIL + BYMONTH/BYMONTHDAY/BYDAY + WKST.                                                                                                                        |
| Natural language       | Bounded English grammar: `now`, `today`, `tomorrow`, `yesterday`, `in N <unit>`, `<N> <unit> ago`, `next <weekday>` / `last <weekday>`. Anything off-grammar raises.                                                                 |
| Multi-calendar         | Trait-driven conversion between Gregorian, Julian, and tabular (arithmetic) Islamic via the shared epoch-day pivot.                                                                                                                  |
| Ecosystem jobs         | "Is this TLS certificate still valid?", "has this JWT expired?" (`exp` / `nbf`), set a deadline / timeout, emit a correctly-stamped log line.                                                                                        |

---

## Deliberate boundaries

| Area                         | Decision                                                                                                                                                                                                                                                                                             |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Calendar systems             | Proleptic Gregorian for the core. Julian and tabular Islamic conform to the `Calendar` trait through the epoch-day pivot. Hebrew, Chinese, observational Hijri, and similar are out of scope; the trait is open so a user can add one without modifying chrono.                                      |
| Leap seconds                 | The Unix timeline ignores leap seconds in arithmetic. `:60` is accepted by the RFC 3339 / RFC 2822 parsers only at `23:59 UTC` (RFC 3339 §5.6) and folded to `:59`; elsewhere it raises. ASN.1 DER rejects `:60` outright per X.690 §11.7. No leap-aware "right/" zones.                             |
| Localization                 | English (C / POSIX) only. `Strftime` and `NaturalDate` read month and weekday names from the `Month` / `Weekday` enums; there is no `Locale` type, no CLDR bundle. Future localization would mirror the typed-zone layer as `chrono/locales/<code>.mojo`, not a runtime data loader.                 |
| String-keyed timezone lookup | No `TimeZone.load(name)`. Mojo's compiler stalls past several hundred arms over distinct parametric `Timezone[N, T]` instantiations (empirically aborted at the 776-arm dispatch). Users import the zone constant directly; backward-compat IANA names re-export through `chrono.timezones.aliases`. |
| Platform                     | Linux-first for the libc clock. Timezone data is generated into typed Mojo constants at build time, so there is no runtime `/usr/share/zoneinfo` dependency on any platform.                                                                                                                         |
