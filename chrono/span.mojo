# Span — a calendar amount (years, months, days): the "human" counterpart to the
# exact Duration vector. Adding a Span is NOT a fixed tick count — years/months are
# applied with end-of-month clamping (Jan 31 + 1 month -> Feb 28/29), then days are
# added exactly. Span is calendar-only by design; exact sub-day amounts stay in
# Duration. That split (non-fixed vs fixed) is the real seam between the two.
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: from spec (relativedelta / java.time Period order: years+months with
# end-of-month clamp, then days). The clamp lives on Date.plus_span; verified
# differential vs a Python reference.

from chrono._core.units import DAYS_PER_WEEK, INT32_MIN, INT32_MAX


@always_inline
def _check_span_field(value: Int, *, field: StaticString) raises -> Int:
    """Bound `value` to the Int32 range. Span carries Int fields, but the
    downstream `year * 12 + month + delta` fold in `_core/civil` runs in
    host-Int — an adversarial `Span(years=Int.MAX/12)` would overflow there
    silently. Int32 is comfortably wider than any realistic span (~178M years
    each way) and matches the year storage in Date / YearMonth, so the bound
    is exact at the layer it actually matters."""
    if value < INT32_MIN or value > INT32_MAX:
        raise Error(
            "chrono.Span: "
            + field
            + " out of Int32 range, got "
            + String(value)
        )
    return value


struct Span(Equatable, TrivialRegisterPassable):
    var _years: Int
    var _months: Int
    var _days: Int

    @always_inline
    def __init__(
        out self, years: Int = 0, months: Int = 0, days: Int = 0
    ) raises:
        self._years = _check_span_field(years, field="years")
        self._months = _check_span_field(months, field="months")
        self._days = _check_span_field(days, field="days")

    @staticmethod
    @always_inline
    def from_years(years: Int) raises -> Self:
        return Self(years=years)

    @staticmethod
    @always_inline
    def from_months(months: Int) raises -> Self:
        return Self(months=months)

    @staticmethod
    @always_inline
    def from_weeks(weeks: Int) raises -> Self:
        return Self(days=weeks * DAYS_PER_WEEK)

    @staticmethod
    @always_inline
    def from_days(days: Int) raises -> Self:
        return Self(days=days)

    @always_inline
    def years(self) -> Int:
        return self._years

    @always_inline
    def months(self) -> Int:
        return self._months

    @always_inline
    def days(self) -> Int:
        return self._days

    @always_inline
    def __add__(self, other: Self) raises -> Self:
        return Self(
            self._years + other._years,
            self._months + other._months,
            self._days + other._days,
        )

    @always_inline
    def __sub__(self, other: Self) raises -> Self:
        return Self(
            self._years - other._years,
            self._months - other._months,
            self._days - other._days,
        )

    @always_inline
    def __neg__(self) raises -> Self:
        return Self(-self._years, -self._months, -self._days)

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return (
            self._years == other._years
            and self._months == other._months
            and self._days == other._days
        )

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)
