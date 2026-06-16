# 03 — Architecture

> **Version:** 0.1.0 | **Updated:** 2026-06-16

The layered model of [02-principles](02-principles.md) turned into modules,
using Mojo-native idioms (value types + parameters + traits — no OOP
inheritance, no dynamic dispatch).

---

## Unit kinds

A consistent vocabulary for every node in the tree.

| Mark        | Kind                 | What                                                                                        | Used for                                                                       |
| ----------- | -------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| `[fn]`      | Independent function | Free function, no state.                                                                    | Core calendar math.                                                            |
| `[group]`   | Grouping struct      | A struct that only groups related static functions, no state.                               | Format parsers, FFI clock.                                                     |
| `[enum]`    | Typed enum           | Struct + `comptime` members (DType style).                                                  | `ClockId`, `Weekday`, `Month`, `Continent`, `Frequency`, `TimeUnit`.           |
| `[value]`   | Value struct         | `TrivialRegisterPassable` (or `(ImplicitlyCopyable, Movable)` when carrying inline arrays). | `Duration`, `Instant`, `Date`, `Time`, `DateTime`, `Offset`, `Timezone[N, T]`. |
| `[builder]` | Builder struct       | Mutable / fluent (`var self`), validates at `.build()`.                                     | `DateTimeBuilder`.                                                             |
| `[trait]`   | Trait                | A pluggable boundary (static dispatch).                                                     | `Calendar` (Gregorian / Julian / Islamic implementations).                     |

A unit is _either_ a single function _or_ a struct that only groups similar
functions. Coupling is minimized so units snap in and out.

---

## Module tree

```
chrono/
│
├─ _core/                       ── L0 FOUNDATION (knows nothing of calendars/zones)   [TIMELINE]
│   ├─ civil.mojo       [fn]    days_since_epoch_from_date · date_from_days_since_epoch · weekday · is_leap_year · days_in_month
│   ├─ civil_batch.mojo [fn]    same, SIMD-columnar (lanes of epoch-days <-> lanes of Y/M/D)
│   ├─ clock.mojo       [group] Clock.now(ClockId) — clock_gettime FFI, OS-gated
│   ├─ clock_id.mojo    [enum]  ClockId {REALTIME, MONOTONIC}
│   └─ units.mojo       [fn]    shared time-unit + range constants
│
├─ duration.mojo        [value] Duration                       ── VECTOR (affine)
├─ instant.mojo         [value] Instant[clock = REALTIME]      ── POINT  (affine)
│
├─ enums.mojo           [enum]  Weekday · Month
├─ date.mojo            [value] Date  ─┐
├─ time.mojo            [value] Time  ─┤── VIEW (naive)
├─ datetime.mojo        [value] DateTime = Date ⊕ Time ─┘
├─ partials.mojo        [value] YearMonth · MonthDay
├─ builder.mojo         [builder] DateTimeBuilder
├─ now.mojo             [group] Now.utc_datetime / utc_date / utc_time
│
├─ format/                      ── L4 SERIALIZATION (one independent unit per format)
│   ├─ rfc3339.mojo     [group] Rfc3339.format / parse / parse_to_instant
│   ├─ strftime.mojo    [group] Strftime.format / parse (English / C locale, names from Weekday/Month enums)
│   ├─ iso_duration.mojo[group] IsoDuration.format / parse (strict canonical order)
│   ├─ rfc2822.mojo     [group] Rfc2822 + HttpDate (RFC 7231 IMF-fixdate)
│   └─ asn1.mojo        [group] Asn1Time — X.509 UTCTime / GeneralizedTime (DER)
│
├─ offset.mojo          [value] Offset (fixed UTC offset)
│
├─ continent.mojo       [enum]  Continent (ASIA · EUROPE · AMERICAS · AFRICA · OCEANIA · ANTARCTICA · ETC)
├─ timezone.mojo        [value] Timezone[transition_count, type_count] (the parametric struct)
├─ timezones/                   ── L3 LENS: typed IANA zone constants (524 zones)
│   ├─ <area>/<location>.mojo   [value]  comptime <ZONE> = Timezone[N, T](…)
│   └─ aliases.mojo    [group]  252 IANA Link aliases as comptime constants
├─ countries/                   ── per-country structs (249 ISO 3166 entries)
│   └─ <continent>/<country>.mojo [value]  struct <Country> with CODE/NAME/FLAG/CONTINENT/LOCALES + zones()
│
├─ zoned_datetime.mojo  [value] ZonedDateTime (parametric over Timezone[N, T])  ── VIEW + LENS
├─ offset_datetime.mojo [value] OffsetDateTime                                  ── VIEW + minimal LENS
├─ span.mojo            [value] Span (calendar arithmetic, clamps)
├─ calendar.mojo        [fn]    iso_week_date · easter · IsoWeekDate
├─ calendars.mojo       [trait] Calendar + Gregorian / Julian / Islamic (tabular)
│
├─ recurrence/                  ── L5 RECURRENCE
│   └─ rrule.mojo       [group] RecurrenceRule (RFC 5545 RRULE) · Frequency · WeekdayRule
├─ natural.mojo         [group] NaturalDate (bounded English natural-language parser) · TimeUnit
│
├─ _internal/                   ── PRIVATE helpers (no public surface)
│   ├─ charset.mojo    [fn]     ASCII byte constants used by every parser
│   ├─ scanner.mojo    [group]  Scanner — cursor-based fixed-format parser (take_int / expect / accept / accept_text / take_text / take_fraction_nanoseconds)
│   └─ text.mojo       [fn]     pad · fractional_seconds · format_offset_hhmm · fold_leap_second
│
└─ __init__.mojo        [group] public re-exports
```

---

## Dependency rule

Arrows go **downward only, never cyclic**.

```
__init__               → (every public type)
format/*               → values
zoned_datetime         → {datetime, timezone}
timezones/*            → {timezone, continent}
countries/*            → {continent, timezone, individual zone constants}
instant                → {duration, _core/clock}
date / time / datetime → {_core/civil, enums}
_core/civil            → (nothing — pure math)
_core/clock            → duration (a clock reading IS a Duration since the epoch)
```

Consequence: adding a format, a calendar, or a new IANA zone cannot touch the
timeline. Each unit is independently testable and replaceable.

---

## Typed timezone layout

The IANA database is **embedded as `comptime` Mojo constants** — not a binary
blob parsed at startup, not a runtime file lookup. Each canonical IANA zone
gets its own file under `chrono/timezones/<area>/<location>.mojo`:

```mojo
# chrono/timezones/asia/bangkok.mojo
from chrono.timezone import Timezone
from chrono.continent import Continent

comptime BANGKOK = Timezone[2, 3](
    name="Asia/Bangkok",
    area="Asia",
    location="Bangkok",
    continent=Continent.ASIA,
    transitions=[-2840164924, -1570084924],
    type_indices=[1, 2],
    offsets=[24124, 24124, 25200],
    is_dst=[0, 0, 0],
    posix_has_rule=True, posix_has_dst=False,
    posix_std_offset=25200, posix_dst_offset=25200,
    posix_start_month=0, posix_start_week=0, posix_start_day=0, posix_start_time=0,
    posix_end_month=0,   posix_end_week=0,   posix_end_day=0,   posix_end_time=0,
)
```

The `Timezone[transition_count, type_count]` parameters are the SHAPE of the
transition table; with the table inlined as `comptime` `InlineArray` data, the
whole zone is part of the compiled binary and `offset_at` is two pointer reads
plus a binary search.

### Layout rationale

IANA is keyed by **area / city**, not by country (country ↔ zone is
many-to-many — the United States alone has 29 zones). So:

| Element                       | Decision                                                                                                                                                                                                                                                                                                                                                                                |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Per-zone files                | One file per IANA `Area/City` under `timezones/<area>/<location>.mojo`. 524 zones from `tzdata 2026b`, verified against `zoneinfo.available_timezones()` at generation time. A zone shared by multiple countries (Asia/Bangkok for TH/CX/KH/LA/VN) is defined ONCE in its own file and imported by every country that references it; Mojo's import system deduplicates at compile time. |
| Backward-compat aliases       | The 252 `L <target> <alias>` rows from `tzdata.zi` are emitted into `chrono/timezones/aliases.mojo` as `comptime <ALIAS> = <CANONICAL>`. Importing the alias yields the EXACT same comptime object — the alias is completely free, no new memory.                                                                                                                                       |
| Country index                 | Per-country structs in `chrono/countries/<continent>/<country>.mojo` (249 entries). Each has `CODE` / `NAME` / `FLAG` / `CONTINENT` / `LOCALES` comptime members + a `zones()` static returning a typed `Tuple[Timezone[…], …]` of the country's IANA zones. Country is "look up by country", not the primary key.                                                                      |
| Generated, never hand-written | The per-file constants for zones, countries, and aliases were emitted at build time from IANA TZif (2026b), `zone1970.tab`, and `tzdata.zi`. Completeness was verified by diffing the emitted zone set against Python `zoneinfo.available_timezones()` at generation time — dropping a zone is a failing generator run.                                                                 |

### Local wall-clock resolution

`Timezone.local_lookup(local_seconds, fold)` resolves a wall-clock time to its
UTC offset under PEP 495 fold / gap semantics. It enumerates every distinct
offset the zone could be in (every historical type plus the POSIX std / dst)
and tests each candidate via `offset_at(local - O) == O`. The number of valid
candidates determines the case:

| Valid candidates | Case        | Result                                                                                                                                                                                                    |
| ---------------: | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                0 | gap         | Walk the transition table for the spring-forward window containing `L`; return its pre-gap offset (fold=False) or post-gap offset (fold=True). Falls back to a ±1-day sample for the POSIX-future region. |
|                1 | unambiguous | Return it.                                                                                                                                                                                                |
|                2 | fold        | Return the larger offset (chronologically first, e.g. EDT just before fall-back) for `fold=False`, the smaller for `fold=True`.                                                                           |

Candidate enumeration is independent of transition spacing, so the algorithm
is correct even if two transitions occur within a 24-hour window — a case not
present in current IANA data but no longer a latent bug.

---

## Performance and SIMD policy

`chrono` uses SIMD deliberately, only where it wins.

| Position                                | Rationale                                                                                                                                                                                                                                                                                                                                              |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Not for single operations               | One `now()`, one `civil_from_days`, parsing one timestamp is ~10 integer ops; vectorizing a single value is pure overhead. The scalar path stays scalar.                                                                                                                                                                                               |
| Yes for batches / timestamp columns     | Converting a whole array of epoch-days to (Y/M/D), or bulk parse / format (logs, databases, dataframes). Hinnant's algorithm is branchless integer arithmetic, so it vectorizes cleanly: every division is by a comptime constant (400, 146097, 153, …) which LLVM lowers to multiply-shift, and the `month <= 2` choice becomes a SIMD masked select. |
| Generic `SIMD[T, W]`, no intrinsics     | Date math is just integer `+ − × //`. Generic `SIMD` auto-lowers to AVX-512 on capable CPUs AND stays portable — AVX-512 throughput with no feature-gate burden. The batch API is struct-of-arrays (lanes of epoch-days in, lanes of fields out).                                                                                                      |
| Scalar correct first, SIMD batch second | You cannot vectorize what is not yet correct. The scalar spine is built and verified first; the vectorized batch path comes after, verified bit-identical to the scalar path on the same oracle (`_core/civil_batch` vs `_core/civil` across a ±3 M-day sweep, 6024 checks, 0 mismatch).                                                               |
