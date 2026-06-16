# 07 — Verified Mojo idioms

> **Version:** 0.1.0 | **Updated:** 2026-06-16

Mojo `1.0.0b3.dev2026061606` removed several idioms and added others. Every
pattern below is in active use in the chrono codebase; the right-hand column
points at a representative production file so a new contributor can see the
idiom applied in real code.

---

## Removed / changed (would bite if guessed)

| Old (gone)                      | Correct here                                                                                                    | Seen in                                                                                          |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| `fn`                            | `def` only.                                                                                                     | Every chrono module.                                                                             |
| `@register_passable("trivial")` | Conform to the `TrivialRegisterPassable` trait.                                                                 | `chrono/duration.mojo`, `chrono/instant.mojo`, `chrono/date.mojo`.                               |
| `@value` / `@fieldwise_init`    | No decorators; explicit `def __init__(out self, …)`.                                                            | `chrono/enums.mojo`, every value struct.                                                         |
| `owned self`                    | `var self` (with `return self^`) for owned / fluent; `mut self` for in-place.                                   | `chrono/builder.mojo` (fluent), `chrono/_internal/scanner.mojo` (`mut self`).                    |
| `UnsafePointer[T].alloc(n)`     | `List[T](unsafe_uninit_length=n)` + `.unsafe_ptr()`, or `InlineArray[T, N]` when the size is known at comptime. | `chrono/_core/clock.mojo` (clock_gettime FFI buffer), `chrono/timezone.mojo` (transition table). |
| Tuple return `(a, b, c)`        | A small struct (or `mut` out-params). Tuples in arbitrary positions are rejected by the parser.                 | `chrono/_core/civil.mojo` returns `YearMonthDay`, not `(year, month, day)`.                      |
| `@parameter if`                 | `comptime if` (no `@parameter` prefix). Same compile-time branch elision; only the taken branch is compiled.    | `chrono/_core/clock.mojo` (OS gating), `chrono/timezone.mojo` (zero-transition).                 |

---

## Confirmed working

| Idiom                                    | Form                                                                                                                                                                                                              | Seen in                                                                                                                   |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| Static-string return                     | `def name(self) -> StaticString`                                                                                                                                                                                  | `chrono/enums.mojo` (`Weekday.name`, `Month.name`), `chrono/timezone.mojo` (`name` field).                                |
| Typed enum                               | `struct E(ImplicitlyCopyable, Movable, Equatable)` + explicit `__init__` + `comptime NAME = E(...)`                                                                                                               | `chrono/enums.mojo`, `chrono/_core/clock_id.mojo`, `chrono/continent.mojo`, `chrono/recurrence/rrule.mojo` (`Frequency`). |
| Enum as struct parameter (with default)  | `struct Instant[clock: ClockId = ClockId.REALTIME]`                                                                                                                                                               | `chrono/instant.mojo`.                                                                                                    |
| `comptime` Self member                   | `comptime ZERO = Duration(0, 0)` at module level inside the struct.                                                                                                                                               | `chrono/duration.mojo`, `chrono/offset.mojo` (`UTC`), `chrono/enums.mojo` (`MONDAY`, `JANUARY`, …).                       |
| Fluent builder                           | `def year(var self, …) -> Self: …; return self^` chains cleanly.                                                                                                                                                  | `chrono/builder.mojo`.                                                                                                    |
| Wall-clock FFI                           | `external_call["clock_gettime", Int32](Int32(0), buf.unsafe_ptr())` over `buf = List[Int64](unsafe_uninit_length=2)` returning `(rc, [tv_sec, tv_nsec])`.                                                         | `chrono/_core/clock.mojo`.                                                                                                |
| Keyword-only `__init__` overload         | `def __init__(out self, *, days_since_epoch: Int32)` alongside a validating positional ctor.                                                                                                                      | `chrono/date.mojo` (internal vs validating), `chrono/recurrence/rrule.mojo` (`TimeUnit`).                                 |
| `comptime if` for OS gating              | `comptime _CLOCK_MONOTONIC = 6 if CompilationTarget.is_macos() else 1`.                                                                                                                                           | `chrono/_core/clock.mojo`.                                                                                                |
| `comptime if` to elide zero-length array | `comptime if Self.transition_count > 0: for i in range(Self.transition_count): self.transitions[i]`. `InlineArray[T, 0]` doesn't type-check indexing — the comptime branch elides it.                             | `chrono/timezone.mojo` (`offset_at` zero-transition branch, `local_lookup` gap-search).                                   |
| Parametric `Timezone[N, T]`              | `struct Timezone[transition_count: Int, type_count: Int](ImplicitlyCopyable, Movable)` carrying `InlineArray[Int64, Self.transition_count]`. Reference `Self.<param>` inside the struct, not the bare param name. | `chrono/timezone.mojo`, `chrono/timezones/asia/bangkok.mojo` (and 523 other zone files).                                  |
| Mixed-arity tuple return                 | `def zones() -> Tuple[Timezone[2, 3], Timezone[9, 6]]` works — different parametric instantiations in the same Tuple.                                                                                             | `chrono/countries/asia/vietnam.mojo` (and 248 other country files).                                                       |
| List-literal `InlineArray` init          | `var x: List[UInt8] = [1, 2, 3]` works; the parametric `Timezone[N, T]` ctor accepts list-literal `transitions=[...]` via positional bind to `InlineArray[Int64, Self.transition_count]`.                         | `chrono/timezones/asia/bangkok.mojo` (every per-zone constructor).                                                        |
| `accept_text(literal)` cursor probe      | `Scanner.accept_text(literal) -> Bool` advances on match, leaves cursor unchanged on miss. Used when a closed vocabulary needs longest-prefix matching (strftime weekday + month names).                          | `chrono/_internal/scanner.mojo`, `chrono/format/strftime.mojo` (`Strftime.parse`).                                        |

---

## House style

| Rule               | Detail                                                                                                                                                                                      |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Stdlib import path | `from std.ffi import external_call`, `from std.memory import UnsafePointer`, `from std.collections.inline_array import InlineArray`. Stdlib is namespaced under `std.`.                     |
| Value struct       | Explicit `def __init__(out self, …)`. Conform to `(Copyable, ImplicitlyCopyable, Movable)` or `(TrivialRegisterPassable)`. `@always_inline` on hot paths. `mut self` for in-place mutation. |
| Errors             | `raises`. No silent fallback. Every parser carries the offending value + the valid range in the error message.                                                                              |
| Bare ASCII bytes   | Forbidden. Character bytes are written `ord("T")` (comptime-folded, zero-cost) — never `== 84`. Named constants in `chrono/_internal/charset.mojo` for the bytes referenced more than once. |

---

## Compile-time OS gating

| Pattern                                      | Detail                                                                                                                                                                                                                               |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `from std.sys.info import CompilationTarget` | Exposes `is_linux()` / `is_macos()` at comptime. There is no `is_windows()` on this toolchain — gate the unsupported case as `not (is_linux() or is_macos())`.                                                                       |
| Per-OS comptime constant                     | `comptime _CLOCK_MONOTONIC = 6 if CompilationTarget.is_macos() else 1`. `CLOCK_REALTIME = 0` on both Linux and macOS. `chrono/_core/clock.mojo` maps chrono's logical `ClockId` discriminant to the real POSIX `clockid_t` this way. |
| Unsupported-target guard                     | `constrained[…]` is not importable as a bare symbol here. Use `comptime if (unsupported): raise ...` inside a `raises` function — the branch is comptime-eliminated on supported targets.                                            |

---

## Idioms confirmed during the typed-only migration

| Pattern                                                    | Detail                                                                                                                                                                                                                                                                                                                                                         |
| ---------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Large parametric string dispatch is a compile bomb         | A single Mojo source file containing 776 `if name == "...":` arms, each importing a distinct `Timezone[N, T]` parametric instantiation, hangs the compiler for 90+ seconds before aborting. There is no string-keyed `TimeZone.load(name)`; users import the zone constant directly, and backward-compat aliases re-export through `chrono.timezones.aliases`. |
| Module-level `comptime` constant of a parametric struct    | `comptime BANGKOK = Timezone[2, 3](…)` works at MODULE level. Equivalent `comptime` aliases inside a struct (`comptime GB = LONDON` inside a class body) error — only module-level binding is allowed.                                                                                                                                                         |
| `comptime` member of a parametric struct without a default | Cannot be accessed without binding the parameter (`Instant.UNIX_EPOCH` errors when `Instant` is parametric). Workaround: expose the constant as a `@staticmethod` (`Instant.unix_epoch()`), which uses the default parameter cleanly.                                                                                                                          |
| Parametric struct field type                               | Reference `Self.<param>` inside the struct, not the bare param name. `InlineArray[Int64, Self.transition_count]`, not `InlineArray[Int64, transition_count]`.                                                                                                                                                                                                  |
| Regular `for` over a comptime bound                        | `for i in range(Self.<param>):` iterates at runtime with the bound resolved at compile time. `@parameter for` is deprecated.                                                                                                                                                                                                                                   |
| Variable-width literal matching                            | Don't roll back a destructive `take_text` — add `Scanner.accept_text(literal) -> Bool` to the cursor and only advance on match. Used by `Strftime.parse` for the closed weekday + month vocabulary.                                                                                                                                                            |
