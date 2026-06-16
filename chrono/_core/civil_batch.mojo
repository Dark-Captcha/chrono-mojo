# Columnar (SIMD) civil-date arithmetic — the batch counterpart of _core/civil, for
# converting a whole column of epoch-days <-> (year, month, day) at once (logs, DB
# rows, dataframes). Same Hinnant algorithm, expressed over SIMD[DType.int64, width]
# lanes. It is GENERIC SIMD — no hand-written intrinsics — so it auto-lowers to the
# target's vector unit (AVX-512/AVX2/NEON) and stays portable.
#
# Two facts make this exact and branchless:
#   * SIMD `//` and `%` are FLOOR (Python semantics), so the floor-form Hinnant
#     algorithm is bit-identical to the scalar path over the whole proleptic range,
#     including negative (pre-1970) days — no sign correction needed.
#   * the month/year fixups are done with modular arithmetic instead of a branch or a
#     SIMD mask: month = (month_index + 2) % 12 + 1, year bump = (month_index + 2)//12.
#
# Facets: tier T1 (perf layer) | safety sound | quantum n/a.
# Honesty: not a new algorithm — the scalar core vectorized; verified bit-identical to
# _core/civil across the proleptic range (the scalar path is the oracle).


from chrono._core.units import DAYS_PER_ERA, EPOCH_SHIFT_DAYS, DAYS_PER_WEEK


struct YearMonthDayVector[width: Int](ImplicitlyCopyable, Movable):
    """A lane-parallel year/month/day result (month 1..12, day 1..31 per lane)."""

    var year: SIMD[DType.int64, Self.width]
    var month: SIMD[DType.int64, Self.width]
    var day: SIMD[DType.int64, Self.width]

    @always_inline
    def __init__(
        out self,
        year: SIMD[DType.int64, Self.width],
        month: SIMD[DType.int64, Self.width],
        day: SIMD[DType.int64, Self.width],
    ):
        self.year = year
        self.month = month
        self.day = day


@always_inline
def date_from_days_since_epoch[
    width: Int
](days: SIMD[DType.int64, width]) -> YearMonthDayVector[width]:
    """Civil date of each serial day number (days since 1970-01-01). Hinnant's
    `civil_from_days` in floor form, vectorized."""
    var shifted = days + EPOCH_SHIFT_DAYS
    var era = shifted // DAYS_PER_ERA
    var day_of_era = shifted - era * DAYS_PER_ERA  # [0, 146096]
    var year_of_era = (
        day_of_era
        - day_of_era // 1460
        + day_of_era // 36524
        - day_of_era // 146096
    ) // 365  # [0, 399]
    var shifted_year = year_of_era + era * 400
    var day_of_year = day_of_era - (
        year_of_era * 365 + year_of_era // 4 - year_of_era // 100
    )  # [0, 365]
    var month_index = (day_of_year * 5 + 2) // 153  # [0, 11]
    var day = day_of_year - (month_index * 153 + 2) // 5 + 1  # [1, 31]
    var month = (
        month_index + 2
    ) % 12 + 1  # March=0 -> 3 .. Jan=10 -> 1, Feb=11 -> 2
    var year = shifted_year + (month_index + 2) // 12  # +1 when month <= 2
    return YearMonthDayVector[width](year, month, day)


@always_inline
def days_since_epoch_from_date[
    width: Int
](
    year: SIMD[DType.int64, width],
    month: SIMD[DType.int64, width],
    day: SIMD[DType.int64, width],
) -> SIMD[DType.int64, width]:
    """Serial day number (days since 1970-01-01) of each civil date. Hinnant's
    `days_from_civil` in floor form, vectorized."""
    var month_index = (month + 9) % 12  # March=0 .. Jan=10, Feb=11
    var shifted_year = year - month_index // 10  # -1 when month <= 2
    var era = shifted_year // 400
    var year_of_era = shifted_year - era * 400  # [0, 399]
    var day_of_year = (month_index * 153 + 2) // 5 + (day - 1)  # [0, 365]
    var day_of_era = (
        year_of_era * 365 + year_of_era // 4 - year_of_era // 100 + day_of_year
    )  # [0, 146096]
    return era * DAYS_PER_ERA + day_of_era - EPOCH_SHIFT_DAYS


@always_inline
def weekday_from_days_since_epoch[
    width: Int
](days: SIMD[DType.int64, width]) -> SIMD[DType.int64, width]:
    """Day of week per lane, 0 = Sunday .. 6 = Saturday. Floor `%` makes it total over
    negative days, matching the scalar core."""
    return (days + 4) % DAYS_PER_WEEK
