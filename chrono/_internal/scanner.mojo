# Scanner — a forward byte cursor over a string, for the fixed-grammar timestamp
# parsers (RFC 3339, ASN.1, RFC 2822 offset, RRULE UNTIL). It owns the position, the
# bounds checks, and the digit decoding, so a parser reads as `scanner.take_int(4)` /
# `scanner.expect("-")` instead of hand-indexed byte arithmetic with raw ASCII codes.
#
# Characters are given as one-character strings and compared via `ord(...)`, so the
# source never contains a bare ASCII number like `== 84`.

from chrono._internal import charset
from chrono._core.units import (
    SECONDS_PER_HOUR,
    SECONDS_PER_MINUTE,
    MINUTES_PER_HOUR,
    HOURS_PER_DAY,
)


struct Scanner(Copyable, Movable):
    var _text: String
    var _position: Int

    def __init__(out self, var text: String):
        self._text = text^
        self._position = 0

    @always_inline
    def position(self) -> Int:
        return self._position

    @always_inline
    def remaining(self) -> Int:
        return self._text.byte_length() - self._position

    @always_inline
    def is_at_end(self) -> Bool:
        return self._position >= self._text.byte_length()

    @always_inline
    def _byte(self) -> Int:
        """The current byte as an Int (caller has checked it is in bounds)."""
        return Int(self._text.as_bytes()[self._position])

    def expect(mut self, character: String) raises:
        """Consume one byte that must equal `character`, else raise."""
        if self.is_at_end() or self._byte() != ord(character):
            raise Error(
                "chrono.scan: expected '"
                + character
                + "' at position "
                + String(self._position)
            )
        self._position += 1

    def accept(mut self, character: String) -> Bool:
        """Consume `character` if it is next; report whether it was."""
        if not self.is_at_end() and self._byte() == ord(character):
            self._position += 1
            return True
        return False

    def accept_text(mut self, literal: String) -> Bool:
        """Try to consume the multi-byte `literal` at the current position.
        Returns True on match (advancing position), False otherwise (position
        unchanged). Used by callers that need longest-prefix matching against
        a closed vocabulary (e.g. strftime weekday + month names)."""
        var needed = literal.byte_length()
        if self.remaining() < needed:
            return False
        var bytes = self._text.as_bytes()
        var literal_bytes = literal.as_bytes()
        for k in range(needed):
            if bytes[self._position + k] != literal_bytes[k]:
                return False
        self._position += needed
        return True

    def take_int(mut self, width: Int) raises -> Int:
        """Read exactly `width` digit bytes as an unsigned integer."""
        var value = 0
        for _ in range(width):
            if self.is_at_end() or not charset.is_digit(self._byte()):
                raise Error(
                    "chrono.scan: expected "
                    + String(width)
                    + " digits at position "
                    + String(self._position)
                )
            value = value * 10 + (self._byte() - charset.DIGIT_ZERO)
            self._position += 1
        return value

    def take_text(mut self, count: Int) raises -> String:
        """Consume the next `count` bytes as a String (e.g. a month abbreviation)."""
        if self.remaining() < count:
            raise Error(
                "chrono.scan: expected "
                + String(count)
                + " characters at position "
                + String(self._position)
            )
        var start = self._position
        self._position += count
        return String(self._text[byte = start : self._position])

    def take_offset_hhmm(
        mut self, *, with_colon: Bool, forbid_negative_zero: Bool = False
    ) raises -> Int:
        """Consume `[+-]HH[:]?MM` and return signed seconds east of UTC.

        Validates each component per RFC 3339 §5.6 / RFC 5322 §3.3 (hour
        00..23, minute 00..59) — without this, `+05:75` would silently parse
        to a 75-minute "minute" so long as the total stayed under the 18-hour
        cap. The HH:MM delimiter is mandatory in RFC 3339 and absent in
        RFC 2822 / IMF-fixdate; `with_colon` switches between the two shapes.

        `forbid_negative_zero=True` rejects the `-00:00` form (RFC 3339 §4.3:
        "offset unknown" — chrono has no representation for that). RFC 5322
        permits `-0000` with a different semantic, so the default is False."""
        var negative: Bool
        if self.accept("-"):
            negative = True
        elif self.accept("+"):
            negative = False
        else:
            raise Error(
                "chrono.scan: offset must start with '+' or '-' at position "
                + String(self._position)
            )
        var hour = self.take_int(2)
        if with_colon:
            self.expect(":")
        var minute = self.take_int(2)
        if hour >= HOURS_PER_DAY:
            raise Error(
                "chrono.scan: offset hour out of range (00..23), got "
                + String(hour)
            )
        if minute >= MINUTES_PER_HOUR:
            raise Error(
                "chrono.scan: offset minute out of range (00..59), got "
                + String(minute)
            )
        var magnitude = hour * SECONDS_PER_HOUR + minute * SECONDS_PER_MINUTE
        if negative and magnitude == 0 and forbid_negative_zero:
            raise Error(
                "chrono.scan: '-00:00' means 'offset unknown' (RFC 3339 §4.3)"
                " and has no representation here"
            )
        return -magnitude if negative else magnitude

    def take_fraction_nanoseconds(
        mut self, *, strict_no_trailing_zero: Bool = False
    ) raises -> Int:
        """Read a run of >= 1 digit bytes (a fractional second after '.') and
        scale it to nanoseconds; digits past the 9th are dropped (sub-ns).

        Bounded at 30 fractional digits to defeat the trivial DoS where a
        hostile timestamp carries millions of zero digits after the '.' — the
        scanner would walk every byte. 30 is far past any real-world precision
        (Mojo Int64 covers ~292 years in ns).

        `strict_no_trailing_zero=True` enforces ITU-T X.690 §11.7.4 / DER
        canonical encoding: the last fractional digit must be non-zero, and a
        single-digit `.0` is forbidden (the spec requires the whole `.frac`
        block to be omitted when the value is zero). RFC 3339 allows trailing
        zeros, so the default is False."""
        var nanoseconds = 0
        var scale = 100_000_000  # the first fractional digit is 1e8 ns
        var count = 0
        var last_digit = 0
        while not self.is_at_end() and charset.is_digit(self._byte()):
            if count >= 30:
                raise Error(
                    "chrono.scan: more than 30 fractional digits at position "
                    + String(self._position)
                )
            last_digit = self._byte() - charset.DIGIT_ZERO
            if count < 9:
                nanoseconds += last_digit * scale
                scale //= 10
            self._position += 1
            count += 1
        if count == 0:
            raise Error(
                "chrono.scan: expected fractional digits at position "
                + String(self._position)
            )
        if strict_no_trailing_zero and last_digit == 0:
            raise Error(
                "chrono.scan: DER fraction must omit trailing zeros (X.690"
                " §11.7.4) at position " + String(self._position)
            )
        return nanoseconds
