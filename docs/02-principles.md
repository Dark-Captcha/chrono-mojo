# 02 — First Principles

> **Version:** 0.1.0 | **Updated:** 2026-06-16

The model of time every type in `chrono` is built on, derived from the nature
of time rather than copied from an existing library.

---

## Time is a continuum; a machine has to discretize it

Physical time is continuous; a machine cannot represent a continuum. So we
**count ticks** from an origin (an _epoch_) at a fixed **resolution**
(nanoseconds). At bottom, every time value in chrono is _a count of ticks_.

---

## Two different things are both called "time"

| Sense               | Meaning                                                 | Algebra       |
| ------------------- | ------------------------------------------------------- | ------------- |
| Instant (a point)   | "When did it happen?" — a coordinate on the timeline.   | affine point  |
| Duration (a vector) | "How long?" — the signed difference between two points. | affine vector |

The affine algebra is the deepest structure here:

```
point  − point    = vector
point  + vector   = point
vector + vector   = vector
point  + point    = MEANINGLESS   (adding two timestamps is a category error)
```

Most libraries don't enforce this at the type level, which is a steady source
of bugs. `chrono` does: `Instant − Instant → Duration`, `Instant ± Duration →
Instant`, and there is no `Instant + Instant`.

---

## Humans don't live in ticks — they live in a projection

People read time through the Earth's rotation (days / hours), its orbit
(years), and social convention (calendars, time zones, DST, weeks). A civil
datetime like `2026-06-16 20:40 +07:00` is **not the time itself** — it is the
**projection** of an `Instant` through a **lens** (calendar + timezone) into
human-readable fields. The same `Instant` projected through two zones yields
two different field-sets but the same underlying moment.

---

## Therefore time is made of these layers

| Layer         | What it is                               | Nature                                                |
| ------------- | ---------------------------------------- | ----------------------------------------------------- |
| Tick          | The smallest quantum.                    | Fixed at nanoseconds.                                 |
| Clock         | Which timeline (realtime, monotonic, …). | Type-level parameter on `Instant`.                    |
| Instant       | A point: `(clock, ticks-since-epoch)`.   | Absolute, exact.                                      |
| Duration      | A vector in tick-space.                  | Exact.                                                |
| Lens          | `Calendar` + `Timezone[N, T]`.           | Pluggable, parametric, compile-time-resolved.         |
| Civil view    | `Y / M / D h:m:s`.                       | Derived projection; cheap, recomputable.              |
| Calendar span | Months / years.                          | Human duration; not a fixed tick count, so it clamps. |
| Serialization | Projection to / from text or binary.     | RFC 3339, RFC 2822, ASN.1, ISO 8601 duration, …       |

These layers map directly onto the module tree (see
[03-architecture](03-architecture.md)): `_core` plus value types are the
**timeline**, `timezone.mojo` plus `timezones/` are the **lens**, the civil
structs (`Date`, `Time`, `DateTime`) are the **view**, `format/` is
**serialization**.

---

## What Mojo lets us do that other languages can't

| Property                          | What it buys                                                                                                                                                                                                                                                                                                   |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Layer separation                  | Physics (timeline) ⟂ lens (calendar + zone) ⟂ view (fields). Bundling them into a few god-types is the root cause of timezone bugs in other libraries.                                                                                                                                                         |
| Zero-cost compile-time parameters | `Instant[clock]` specializes per clock. `Timezone[transition_count, type_count]` is parametric on the SHAPE of its transition table, so a zero-transition zone (Etc/UTC) and a many-transition zone (America/New_York) get separately-monomorphized code with no runtime branch on "do you have transitions?". |
| Self-contained, no runtime data   | Every IANA zone is a `comptime` constant in its own file (524 zones + 252 backward-compat aliases). The whole timezone database ships as part of the compiled binary. No file lookups, no `/usr/share/zoneinfo` dependency, identical behaviour in containers / GPU / sandboxed runtimes.                      |
| Type-level safety                 | Mixing clocks, adding two instants, or comparing naive against zoned is a _compile error_, not a runtime exception. The whole class of Python `TypeError`s around naive vs aware datetimes is unrepresentable here.                                                                                            |
| Value semantics plus SIMD         | Instants and durations are trivial register values with no allocation. A whole column of timestamps can be converted to civil fields with SIMD; `_core/civil_batch` does exactly this. No prior datetime library vectorizes the calendar core.                                                                 |
| No hidden global state            | `now()`, time zone, and locale are all explicit parameters. The library is pure, testable, thread-safe.                                                                                                                                                                                                        |

---

## What we deliberately do not "disrupt"

We innovate on **representation, API, performance, and type safety**. But the
Gregorian calendar, the Earth's rotation, and the political history of DST
and timezone changes are **not patterns to break — they are the territory**
and must be modelled faithfully. Getting them "creative" means getting them
wrong. The library breaks with convention in _how it packages time_, never in
how it computes it.
