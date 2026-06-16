# Shared text-formatting helpers for chrono's formatters — the zero-pad, the
# fractional-second suffix, the offset renderer, the leap-second gate, and the
# canonical "<field> out of range" error formatter. (Parsing lives in
# chrono/_internal/scanner.mojo.) Private to the library.

from chrono._core.units import SECONDS_PER_HOUR, SECONDS_PER_MINUTE


def pad(value: Int, width: Int) -> String:
    """Left-pad a non-negative `value` with '0' to at least `width` characters.
    If `value` already has at least `width` digits, returns it unchanged (no
    truncation — silent truncation would let an out-of-range field encode to a
    plausible-looking but wrong string). Negative `value` is the caller's
    contract violation; the leading `-` keeps the result distinguishable rather
    than emitting `0-44`."""
    var s = String(value)
    var deficit = width - s.byte_length()
    if deficit <= 0:
        return s
    return "0" * deficit + s


def fractional_seconds(nanosecond: Int) -> String:
    """A fractional-second suffix — ".5", ".001", … with trailing zeros trimmed — or
    "" when `nanosecond` is 0. Used by RFC 3339, ASN.1, and ISO-8601 duration output."""
    if nanosecond == 0:
        return String("")
    var significant = nanosecond
    var width = 9
    while significant % 10 == 0:
        significant //= 10
        width -= 1
    return "." + pad(significant, width)


def format_offset_hhmm(seconds: Int, *, colon: Bool) -> String:
    """Render a UTC offset in `+HHMM`/`-HHMM` form (RFC 2822) or `+HH:MM`/`-HH:MM`
    (RFC 3339). `seconds` is the signed east-of-UTC count; the caller validates
    the range. One home for the sign + zero-pad + optional separator that both
    formats otherwise repeat verbatim."""
    var s = String("+") if seconds >= 0 else String("-")
    var total = seconds if seconds >= 0 else -seconds
    s += pad(total // SECONDS_PER_HOUR, 2)
    if colon:
        s += ":"
    s += pad((total % SECONDS_PER_HOUR) // SECONDS_PER_MINUTE, 2)
    return s


def fold_leap_second(
    hour: Int, minute: Int, second: Int, *, offset_seconds: Int
) raises -> Int:
    """Leap-second policy. ':60' is only valid at the very last minute of a
    *UTC* day (`23:59:60` with a zero offset); folding it anywhere else would
    silently rewrite the input. Returns 59 for the legitimate fold; raises
    otherwise. Used by every chrono parser that accepts an `SS` field.

    This is STRICTER than RFC 3339 §5.6, which permits the leap second to be
    expressed in any local frame as long as it lands on `23:59:60 UTC` (so
    `00:59:60+01:00` is RFC-conformant for the same instant). chrono requires
    the literal `23:59:60` form with a zero offset because:
      * the leap-second event is unambiguous as `23:59:60Z`;
      * accepting offset-shifted variants needs a UTC reconstruction that the
        single-pass parser doesn't have at this point in the pipeline; and
      * X.690 §11.7 (DER ASN.1) rejects `:60` outright — formats already
        differ on this policy.
    Callers that need RFC-conformant offset-shifted leap parsing can rebuild
    the input as `23:59:60Z` before calling Rfc3339.parse."""
    if second != 60:
        return second
    if hour != 23 or minute != 59 or offset_seconds != 0:
        raise Error(
            "chrono: leap second ':60' is only valid at 23:59 UTC (got "
            + pad(hour, 2)
            + ":"
            + pad(minute, 2)
            + ":60 with offset "
            + String(offset_seconds)
            + "s)"
        )
    return 59


def range_error(
    facility: StaticString,
    field: StaticString,
    value: Int,
    valid_min: Int,
    valid_max: Int,
) -> Error:
    """Canonical 'field out of range' Error — single home for the
    facility-prefixed message that the audit demands every parser raise. Keeps
    every caller honest about both the offending value AND the valid range."""
    return Error(
        "chrono."
        + facility
        + ": "
        + field
        + " out of range ("
        + String(valid_min)
        + ".."
        + String(valid_max)
        + "), got "
        + String(value)
    )


def reject_leap_second(
    facility: StaticString, format_name: StaticString, second: Int
) raises:
    """Raise on ':60' for formats that forbid leap seconds outright (X.690 DER
    §11.7 — both UTCTime and GeneralizedTime). Folding `:60` to `:59` would
    hide whether the issuer encoded a leap second, breaking byte-exact X.509
    validation."""
    if second == 60:
        raise Error(
            "chrono."
            + facility
            + ": leap second ':60' is not allowed in DER "
            + format_name
        )
