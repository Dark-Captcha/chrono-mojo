# SIMD civil batch — verified BIT-IDENTICAL to the scalar _core/civil (the oracle,
# itself verified vs Python). For a spread of epoch-days (negative/proleptic, the
# epoch, modern, far-future, extremes) packed into width-8 SIMD lanes, each lane's
# forward decode, inverse encode, and weekday must equal the scalar result.

from chrono._core import civil
from chrono._core import civil_batch

comptime _WIDTH = 8


def _test_days() -> List[Int64]:
    var d = List[Int64]()
    # proleptic (year < 1), epoch, modern, far future, extremes — 24 values
    d.append(-2000000)
    d.append(-1000000)
    d.append(-719162)
    d.append(-100000)
    d.append(-36524)
    d.append(-1)
    d.append(0)
    d.append(1)
    d.append(11016)
    d.append(19782)
    d.append(20619)
    d.append(20620)
    d.append(50000)
    d.append(100000)
    d.append(146096)
    d.append(146097)
    d.append(500000)
    d.append(2932896)
    d.append(-141427)
    d.append(-98556)
    d.append(16990)
    d.append(2530769)
    d.append(3000000)
    d.append(-5000000)
    return d^


def run() raises -> Int:
    var f = 0
    var days = _test_days()

    var index = 0
    while index < len(days):
        # pack up to _WIDTH days into a SIMD vector (pad the tail by repeating the last)
        var vec = SIMD[DType.int64, _WIDTH](0)
        for lane in range(_WIDTH):
            var src = index + lane
            vec[lane] = days[src] if src < len(days) else days[len(days) - 1]

        var batch = civil_batch.date_from_days_since_epoch[_WIDTH](vec)
        var encoded = civil_batch.days_since_epoch_from_date[_WIDTH](
            batch.year, batch.month, batch.day
        )
        var weekday = civil_batch.weekday_from_days_since_epoch[_WIDTH](vec)

        for lane in range(_WIDTH):
            var src = index + lane
            if src >= len(days):
                continue
            var day_number = days[src]
            var scalar = civil.date_from_days_since_epoch(Int(day_number))
            # forward decode bit-identical
            if (
                Int(batch.year[lane]) != scalar.year
                or Int(batch.month[lane]) != scalar.month
                or Int(batch.day[lane]) != scalar.day
            ):
                print(
                    "FAIL forward lane",
                    day_number,
                    "simd",
                    batch.year[lane],
                    batch.month[lane],
                    batch.day[lane],
                    "scalar",
                    scalar.year,
                    scalar.month,
                    scalar.day,
                )
                f += 1
            # inverse encode round-trips to the original day
            if Int(encoded[lane]) != Int(day_number):
                print("FAIL inverse lane", day_number, "got", encoded[lane])
                f += 1
            # weekday matches the scalar core
            if Int(weekday[lane]) != civil.weekday_from_days_since_epoch(
                Int(day_number)
            ):
                print("FAIL weekday lane", day_number, "got", weekday[lane])
                f += 1
        index += _WIDTH

    if f == 0:
        print("test_civil_batch: PASS")
    return f
