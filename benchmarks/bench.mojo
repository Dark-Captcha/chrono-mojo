# bench.mojo — coarse latency numbers for chrono's hot paths. Run with
#   pixi run bench
# RFC3339 format is the one that matters most — every log line round-trips
# through it.

from std.time import perf_counter_ns

from chrono import (
    Date,
    DateTime,
    Duration,
    Instant,
    ClockId,
    Offset,
    Rfc3339,
    YearMonth,
    Now,
)


comptime N: Int = 200_000


def bench_date_construct() raises:
    var t0 = perf_counter_ns()
    var sink = Date(2026, 1, 1)
    for i in range(N):
        sink = Date(2026, 1, ((i % 28) + 1))
    var t1 = perf_counter_ns()
    print(
        "Date(y,m,d)         :",
        Float64(t1 - t0) / Float64(N),
        "ns/call (sink.day=",
        sink.day(),
        ")",
    )


def bench_date_decode_year() raises:
    # Repeated year() / month() / day() calls — exercises the days→y/m/d
    # decode (the expensive direction).
    var d = Date(2026, 6, 18)
    var t0 = perf_counter_ns()
    var acc = 0
    for _ in range(N):
        acc += d.year()
    var t1 = perf_counter_ns()
    print(
        "Date.year()         :",
        Float64(t1 - t0) / Float64(N),
        "ns/call (acc=",
        acc,
        ")",
    )


def bench_date_decode_ymd() raises:
    var d = Date(2026, 6, 18)
    var t0 = perf_counter_ns()
    var acc = 0
    for _ in range(N):
        acc += d.year() + Int(d.month()._value) + d.day()
    var t1 = perf_counter_ns()
    print(
        "Date.y/m/d (sum)    :",
        Float64(t1 - t0) / Float64(N),
        "ns/call (acc=",
        acc,
        ")",
    )


def bench_instant_now() raises:
    # clock_gettime path — REALTIME via std lib if there is one, else FFI.
    var t0 = perf_counter_ns()
    var sink = Instant[ClockId.REALTIME].now()
    for _ in range(N):
        sink = Instant[ClockId.REALTIME].now()
    var t1 = perf_counter_ns()
    print(
        "Instant.now()       :",
        Float64(t1 - t0) / Float64(N),
        "ns/call",
    )


def bench_datetime_from_instant() raises:
    var inst = Instant[ClockId.REALTIME].now()
    var t0 = perf_counter_ns()
    var sink = DateTime.from_utc_instant(inst)
    for _ in range(N):
        sink = DateTime.from_utc_instant(inst)
    var t1 = perf_counter_ns()
    print(
        "DateTime.from_utc   :",
        Float64(t1 - t0) / Float64(N),
        "ns/call (sink.year=",
        sink.year(),
        ")",
    )


def bench_rfc3339_format() raises:
    # The bottleneck for every logged line. Build a DateTime once, format N
    # times.
    var inst = Instant[ClockId.REALTIME].now()
    var dt = DateTime.from_utc_instant(inst)
    var t0 = perf_counter_ns()
    var sink = String("")
    for _ in range(N):
        sink = Rfc3339.format(dt, Offset.UTC)
    var t1 = perf_counter_ns()
    print(
        "Rfc3339.format(UTC) :",
        Float64(t1 - t0) / Float64(N),
        "ns/call (last=",
        len(sink),
        "bytes)",
    )


def bench_rfc3339_format_now() raises:
    # End-to-end: read clock + format. This is what a log line does once per
    # event.
    var t0 = perf_counter_ns()
    var sink = String("")
    for _ in range(N):
        var inst = Instant[ClockId.REALTIME].now()
        var dt = DateTime.from_utc_instant(inst)
        sink = Rfc3339.format(dt, Offset.UTC)
    var t1 = perf_counter_ns()
    print(
        "now+format(end-end) :",
        Float64(t1 - t0) / Float64(N),
        "ns/call (last=",
        len(sink),
        "bytes)",
    )


def main() raises:
    print("chrono-mojo bench (N =", N, ")")
    bench_date_construct()
    bench_date_decode_year()
    bench_date_decode_ymd()
    bench_instant_now()
    bench_datetime_from_instant()
    bench_rfc3339_format()
    bench_rfc3339_format_now()
