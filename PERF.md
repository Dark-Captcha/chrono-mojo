# PERF

Hot-path numbers for chrono. Measured on x86-64 Linux with `pixi run bench`, N=200_000, median of three runs.

## Current

| Path                       | ns/call | Notes                                                         |
| -------------------------- | ------- | ------------------------------------------------------------- |
| `Date(y, m, d)`            | ~8      | y/m/d validation + `days_since_epoch_from_date` calendar math |
| `Date.year()`              | ~0      | DCE'd in tight loops (pure function on register-trivial Date) |
| `Date.y/m/d` (sum)         | ~0      | LLVM CSE collapses repeated decodes                           |
| `Instant.now()`            | ~35     | `clock_gettime(REALTIME)` via vDSO — irreducible              |
| `DateTime.from_utc_instant`| ~4      | division-by-86_400 + Time wrapper                             |
| `Rfc3339.format(UTC)`      | ~65     | one heap alloc + 19-byte fixed-buffer write                   |
| now + format (end-to-end)  | ~103    | the "log a line" cost — `Instant.now()` + datetime + format   |

## What made the format fast

The previous `Rfc3339.format` chained ~20 `String += String` operations through `pad`, `fractional_seconds`, and `format_offset_hhmm` — every `+=` resized a fresh allocation. The rewrite is:

1. **Compute the exact output length up front**: 19 fixed bytes + variable fractional + 1 or 6 byte zone.
2. **One allocation via `String(unsafe_uninit_length=total)`** — direct heap-malloc into the final String.
3. **Direct pointer writes** through `_internal/itoa.write2 / write4`. The two-digit table (`_D100`) is the same trick `fmt`, Rust std, and Go runtime use: each `n in 0..100` has two ASCII bytes stored adjacent, so a two-digit emit is one indexed read instead of `divmod 10 + '0'`. Reference: Andrei Alexandrescu, *Three Optimization Tips for C++* (CppCon 2014).
4. **Batched calendar decode**: `datetime.date().year_month_day()` once, instead of three separate calls to `year() / month() / day()` that each ran `date_from_days_since_epoch`.

Net change vs. the original: **299 ns → 65 ns (4.6×)**. The remaining 65 ns is dominated by the heap allocation (~25 ns), the `clock_gettime` is the floor for any timestamping path (~35 ns), and the byte writes themselves are essentially free.

## Reproducing

```bash
pixi run bench
```

The bench file (`benchmarks/bench.mojo`) is the source of truth — copy it, change `N`, swap inputs, run again. Numbers vary ±10% with CPU frequency scaling; pin to a single core (`taskset -c 0`) for tighter intervals.
