# 06 — Foundations

> **Version:** 0.1.0 | **Updated:** 2026-06-16

The standards bodies, specifications, data sources, algorithms, and prior
libraries this code stands on. The library _understands and re-implements_
from these specs — it does not copy code.

---

## Standards bodies

| Acronym           | Name                                           | Role for chrono                                                                                |
| ----------------- | ---------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| **IETF**          | Internet Engineering Task Force                | Publishes the RFCs.                                                                            |
| **IANA**          | Internet Assigned Numbers Authority            | Maintains the time-zone database (per RFC 6557).                                               |
| **ISO**           | International Organization for Standardization | ISO 8601 (date / time / duration), ISO 3166 (country codes).                                   |
| **ITU-T / ITU-R** | International Telecommunication Union          | Defines UTC (Rec. TF.460); ITU-T X.680 / X.690 define ASN.1 and DER.                           |
| **BIPM / IERS**   | Weights & Measures / Earth Rotation Service    | Keep UTC / TAI; decide leap seconds. Chrono ignores leap seconds in arithmetic by design.      |
| **POSIX / TOG**   | The Open Group, IEEE 1003.1                    | `time_t`, `strftime` / `strptime`, the `TZ` string.                                            |
| **ISO/IEC**       | ISO + IEC                                      | C89 / C99 — defines the `strftime` directive set.                                              |
| **TC39 / ECMA**   | —                                              | The Temporal API (JS) — chrono's north star for type-level Instant / Plain / Zoned separation. |
| **JCP / JSR**     | Java Community Process                         | JSR-310 (`java.time`) — Duration vs Period; compose small types.                               |

---

## Specifications implemented

| Spec                         | Body  | Defines                                         | Used for                                                                 |
| ---------------------------- | ----- | ----------------------------------------------- | ------------------------------------------------------------------------ |
| **ISO 8601-1 / 8601-2:2019** | ISO   | Date-time and duration representation.          | Base of every wire format chrono ships.                                  |
| **RFC 3339**                 | IETF  | ISO-8601 profile for Internet timestamps.       | `format/rfc3339`.                                                        |
| **RFC 5322** (←2822←822)     | IETF  | Email date.                                     | `format/rfc2822`.                                                        |
| **RFC 9110** (←7231←2616)    | IETF  | HTTP — the `Date` header (IMF-fixdate).         | `format/rfc2822 HttpDate`.                                               |
| **RFC 9636** (←8536)         | IETF  | TZif — the binary zoneinfo format.              | Consumed at build time to generate typed zone constants.                 |
| **RFC 6557**                 | IETF  | IANA tz-db maintenance procedure.               | Data provenance.                                                         |
| **RFC 5545**                 | IETF  | iCalendar; RRULE recurrence.                    | `recurrence/rrule`.                                                      |
| **POSIX.1 (IEEE 1003.1)**    | TOG   | `time_t`, strftime, the `TZ` string.            | Clock FFI; POSIX-footer rule in `Timezone[N, T]`.                        |
| **ISO/IEC 9899 (C89 / C99)** | ISO   | The strftime directive set.                     | `format/strftime` (`format` + `parse`).                                  |
| **ISO 3166-1**               | ISO   | Country codes (VN, US, …).                      | Per-country structs under `chrono/countries/<continent>/<country>.mojo`. |
| **ITU-T X.680 / X.690**      | ITU-T | ASN.1 UTCTime / GeneralizedTime + DER encoding. | `format/asn1` (X.509 validity).                                          |
| **RFC 5280**                 | IETF  | The X.509 profile using those time types.       | `crypto-mojo` certificate validity (downstream consumer).                |

Glossary: DER = Distinguished Encoding Rules; ASN.1 = Abstract Syntax
Notation One; UTC = Coordinated Universal Time; TAI = International Atomic
Time; DST = Daylight Saving Time; TZif = Time Zone Information Format;
IMF = Internet Message Format.

---

## Data sources

| Source                         | What                                                                                                                   | When consumed                                                                                                                                                                                                                            |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **IANA Time Zone Database**    | The "tz database / tzdata / Olson database" (Arthur David Olson, now Paul Eggert). Releases tagged `2026a`, `2026b`, … | Build-time only. The TZif binary at `/usr/share/zoneinfo` (RFC 9636) is the source for the per-zone `comptime Timezone[N, T]` constants under `chrono/timezones/<area>/<location>.mojo`. No runtime dependency on `/usr/share/zoneinfo`. |
| **`zone1970.tab`**             | Country (ISO 3166) → zone mapping.                                                                                     | Build-time. Drives the per-country structs in `chrono/countries/<continent>/`.                                                                                                                                                           |
| **`tzdata.zi`**                | The canonical text release; carries the 252 backward-compat `L <target> <alias>` rows.                                 | Build-time. Drives the alias constants in `chrono/timezones/aliases.mojo`.                                                                                                                                                               |
| **`leap-seconds.list`** (IERS) | Leap-second insertion history.                                                                                         | Reference only — chrono ignores leap seconds in arithmetic.                                                                                                                                                                              |

---

## Algorithmic foundations

| Foundation                                | What it is                                                           | Where chrono uses it                                           |
| ----------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------- |
| **Proleptic Gregorian calendar**          | The 1582 Gregorian calendar extended backward indefinitely.          | The core calendar system; `_core/civil`.                       |
| **Unix / POSIX time**                     | Seconds since `1970-01-01 00:00:00 UTC`, leap seconds ignored.       | The `Instant` timeline.                                        |
| **Howard Hinnant date algorithms (2021)** | `days_from_civil` / `civil_from_days`; the "400-year era" trick.     | `_core/civil` (re-implemented from scratch).                   |
| **Julian Day Number**                     | Continuous day count from `−4713-01-01` proleptic Julian.            | Astronomical pivot for `JulianCalendar` and `IslamicCalendar`. |
| **Reingold-Dershowitz tabular Islamic**   | Arithmetic Islamic calendar — 30-year leap cycle, epoch JDN 1948440. | `IslamicCalendar` in `calendars.mojo`.                         |
| **Richards algorithm** (via JDN)          | Julian Day Number ↔ proleptic Julian civil conversion.               | `JulianCalendar` in `calendars.mojo`.                          |
| **ISO 8601 week date**                    | Week starts Monday; week 1 holds the year's first Thursday.          | `calendar.iso_week_date`.                                      |
| **Computus (Gauss)**                      | Easter Sunday computation.                                           | `calendar.easter`.                                             |
| **PEP 495 fold semantics**                | Disambiguates wall-clock times at DST gap / fold.                    | `Timezone.local_lookup` and `ZonedDateTime.from_local`.        |

---

## Prior libraries (design lessons, not code)

| Library                                   | Language          | Lesson absorbed                                                                        |
| ----------------------------------------- | ----------------- | -------------------------------------------------------------------------------------- |
| **Temporal**                              | JavaScript (TC39) | Explicit type separation (Instant / Plain* / Zoned*).                                  |
| **java.time (JSR-310)**                   | Java              | Compose small types into bigger; separate `Duration` (exact) from `Period` (calendar). |
| **NodaTime**                              | .NET              | Safe zone API; explicit "is this DST?" / fold queries.                                 |
| **chrono / time / jiff**                  | Rust              | Naive vs aware at the type level; affine point / vector treatment.                     |
| **std::chrono + date.h**                  | C++               | Hinnant's day-civil algorithms; compile-time resolution parameters.                    |
| **datetime / zoneinfo / dateutil / pytz** | Python            | Familiar surface; PEP 495 / 615 `fold` lesson; the strptime directive set.             |

---

## Authoritative references

`rfc-editor.org` · `iana.org/time-zones` ·
`howardhinnant.github.io/date_algorithms.html` · `peps.python.org` ·
`developer.mozilla.org` (Temporal).
