# IsoDuration — ISO 8601 duration strings, "P[nY][nM][nW][nD][T[nH][nM][nS]]"
# (e.g. "P1Y2M3DT4H5M6S", "PT1H30M", "P1W", "PT1.5S"). Combines the calendar part
# (a Span: years/months/days) with the exact time part (a Duration). 'M' means
# months before the 'T', minutes after it. Non-negative components are expected.
#
# Facets: tier T0 (spine) | safety sound (bounds-checked parse) | quantum n/a.
# Honesty: from spec (ISO 8601-1:2019 §5.5.2.2). KAT + round-trip. Independent unit.

from chrono.span import Span
from chrono.duration import Duration
from chrono._internal.text import fractional_seconds
from chrono._internal import charset
from chrono._core.units import (
    SECONDS_PER_HOUR,
    SECONDS_PER_MINUTE,
    DAYS_PER_WEEK,
)

# ISO 8601 duration designators ("P1Y2M3DT4H5M6S"); 'M' is months before the 'T' and
# minutes after it (the parser tracks which side it is on).
comptime _PERIOD = ord("P")
comptime _TIME_SEP = ord("T")
comptime _YEARS = ord("Y")
comptime _MONTHS_OR_MINUTES = ord("M")
comptime _WEEKS = ord("W")
comptime _DAYS = ord("D")
comptime _HOURS = ord("H")
comptime _SECONDS = ord("S")


@always_inline
def _designator_rank(designator: Int, in_time: Bool) -> Int:
    """Canonical position of a designator in its half (1-based). Returns 0 for
    a designator not legal in that half — the caller raises on 0."""
    if not in_time:
        if designator == _YEARS:
            return 1
        if designator == _MONTHS_OR_MINUTES:
            return 2
        if designator == _WEEKS:
            return 3
        if designator == _DAYS:
            return 4
        return 0
    if designator == _HOURS:
        return 1
    if designator == _MONTHS_OR_MINUTES:
        return 2
    if designator == _SECONDS:
        return 3
    return 0


struct IsoDurationValue(Equatable, TrivialRegisterPassable):
    """The parts of an ISO 8601 duration: a calendar Span + an exact Duration."""

    var span: Span
    var duration: Duration

    @always_inline
    def __init__(out self, span: Span, duration: Duration):
        self.span = span
        self.duration = duration

    @always_inline
    def __eq__(self, other: Self) -> Bool:
        return self.span == other.span and self.duration == other.duration

    @always_inline
    def __ne__(self, other: Self) -> Bool:
        return not (self == other)


struct IsoDuration:
    @staticmethod
    def format(span: Span, duration: Duration) raises -> String:
        """Render a Span+Duration as `P[nY][nM][nD][T[nH][nM][nS]]`. ISO 8601-1
        has no notion of a negative duration (8601-2's `-P…` sign-before-P
        is also not produced here), so negative components raise rather than
        emit a non-conformant string like `"P-2Y"` or floor-decomposing into
        `"PT-1H"`. Use `-IsoDuration.format(-span, -duration)` if the caller
        truly wants a sign prefix."""
        if span.years() < 0 or span.months() < 0 or span.days() < 0:
            raise Error(
                "chrono.IsoDuration: negative Span has no ISO 8601-1"
                " representation (got years="
                + String(span.years())
                + ", months="
                + String(span.months())
                + ", days="
                + String(span.days())
                + ")"
            )
        if duration.is_negative():
            raise Error(
                "chrono.IsoDuration: negative Duration has no ISO 8601-1"
                " representation"
            )
        var out = String("P")
        if span.years() != 0:
            out += String(span.years()) + "Y"
        if span.months() != 0:
            out += String(span.months()) + "M"
        if span.days() != 0:
            out += String(span.days()) + "D"

        var total = duration.total_seconds()
        var nanosecond = Int(duration.nanosecond())
        var hours = total // SECONDS_PER_HOUR
        var minutes = (total % SECONDS_PER_HOUR) // SECONDS_PER_MINUTE
        var seconds = total % SECONDS_PER_MINUTE
        if hours != 0 or minutes != 0 or seconds != 0 or nanosecond != 0:
            out += "T"
            if hours != 0:
                out += String(hours) + "H"
            if minutes != 0:
                out += String(minutes) + "M"
            if seconds != 0 or nanosecond != 0:
                out += String(seconds)
                out += fractional_seconds(nanosecond)
                out += "S"

        if out == "P":  # everything zero
            return String("PT0S")
        return out

    @staticmethod
    def parse(text: String) raises -> IsoDurationValue:
        """Parse an ISO 8601 duration string, enforcing the spec's strictness:
        - designators must appear in canonical order (Y, M, W, D, T H, M, S);
          duplicates and out-of-order designators raise (§5.5.2.1);
        - the week form (W) is mutually exclusive with Y/M/D and with the time
          part (§5.5.2.2);
        - a fractional part is allowed ONLY on the smallest used component
          (only the seconds field here), per §5.5.2.3.
        """
        var b = text.as_bytes()
        var n = len(b)
        if n < 2 or Int(b[0]) != _PERIOD:
            raise Error(
                "chrono.IsoDuration: must start with 'P', got '" + text + "'"
            )
        var years = 0
        var months = 0
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var nanosecond = 0
        var i = 1
        var in_time = False
        var saw_component = False
        # Monotonic rank in canonical order; out-of-order/duplicate designators
        # raise. The T separator resets `last_rank` to 0 since the time part
        # has its own H<M<S ordering.
        var last_rank = 0
        var saw_week = False
        var saw_non_week_date = False
        while i < n:
            if Int(b[i]) == _TIME_SEP:
                if in_time:
                    raise Error(
                        "chrono.IsoDuration: duplicate 'T' in '" + text + "'"
                    )
                in_time = True
                last_rank = 0
                i += 1
                continue
            var value = 0
            var digits = 0
            while i < n and charset.is_digit(Int(b[i])):
                # 15 digits keeps the multiply safely in Int64 and is far past
                # any real-world year/month/day count.
                if digits >= 15:
                    raise Error(
                        "chrono.IsoDuration: number too large at position "
                        + String(i)
                        + " in '"
                        + text
                        + "'"
                    )
                value = value * 10 + (Int(b[i]) - charset.DIGIT_ZERO)
                i += 1
                digits += 1
            var saw_digit = digits > 0
            var fractional = 0
            var has_fractional = False
            if i < n and Int(b[i]) == charset.PERIOD:
                i += 1
                has_fractional = True
                var scale = 100_000_000
                var frac_digits = 0
                while i < n and charset.is_digit(Int(b[i])):
                    if frac_digits >= 30:
                        raise Error(
                            "chrono.IsoDuration: more than 30 fractional digits"
                            " at position " + String(i)
                        )
                    if frac_digits < 9:
                        fractional += (Int(b[i]) - charset.DIGIT_ZERO) * scale
                        scale //= 10
                    i += 1
                    frac_digits += 1
            if not saw_digit:
                raise Error(
                    "chrono.IsoDuration: missing component value in '"
                    + text
                    + "' at position "
                    + String(i)
                )
            if i >= n:
                raise Error(
                    "chrono.IsoDuration: number with no designator in '"
                    + text
                    + "' (ended at position "
                    + String(i)
                    + ")"
                )
            var designator = Int(b[i])
            i += 1
            saw_component = True
            # Compute the canonical rank; non-canonical designator in the wrong
            # half is caught by the rank assignment below (returns 0).
            var rank = _designator_rank(designator, in_time)
            if rank == 0:
                raise Error(
                    "chrono.IsoDuration: bad "
                    + String("time" if in_time else "date")
                    + " designator '"
                    + chr(designator)
                    + "' in '"
                    + text
                    + "'"
                )
            if rank <= last_rank:
                raise Error(
                    "chrono.IsoDuration: designators out of order or duplicated"
                    " ('" + chr(designator) + "' in '" + text + "')"
                )
            last_rank = rank
            # Fractional is only valid on the smallest USED component — for the
            # subset we support that means the seconds field in time mode.
            if has_fractional and not (in_time and designator == _SECONDS):
                raise Error(
                    "chrono.IsoDuration: fractional value is only allowed on"
                    " the seconds component, got '."
                    + String(fractional)
                    + "' on '"
                    + chr(designator)
                    + "' in '"
                    + text
                    + "'"
                )
            if not in_time:
                if designator == _YEARS:
                    years = value
                    saw_non_week_date = True
                elif designator == _MONTHS_OR_MINUTES:  # months before the 'T'
                    months = value
                    saw_non_week_date = True
                elif designator == _WEEKS:
                    days += value * DAYS_PER_WEEK
                    saw_week = True
                elif designator == _DAYS:
                    days += value
                    saw_non_week_date = True
            else:
                if designator == _HOURS:
                    hours = value
                elif designator == _MONTHS_OR_MINUTES:  # minutes after the 'T'
                    minutes = value
                elif designator == _SECONDS:
                    seconds = value
                    nanosecond = fractional
        if not saw_component:
            raise Error("chrono.IsoDuration: no components in '" + text + "'")
        # ISO 8601 §5.5.2.2: the week form is mutually exclusive with the
        # other date and time components.
        if saw_week and (saw_non_week_date or in_time):
            raise Error(
                "chrono.IsoDuration: 'W' is mutually exclusive with other"
                " date/time components in '" + text + "'"
            )
        var duration = Duration.from_seconds(
            Int64(
                hours * SECONDS_PER_HOUR
                + minutes * SECONDS_PER_MINUTE
                + seconds
            )
        ) + Duration.from_nanoseconds(Int64(nanosecond))
        return IsoDurationValue(Span(years, months, days), duration)
