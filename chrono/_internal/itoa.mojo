# itoa — small-integer-to-ASCII decimal helpers. The two-digit lookup table
# (`_D100`) is the same trick `fmt`, Rust's `std`, Go, and modern itoa
# implementations all use: every value in 0..100 has two ASCII bytes side by
# side, so two-digit chunks take one indexed read + one 16-bit store instead
# of a divide / mod pair plus two `+ '0'` ops.
#
# Authoritative reference: Andrei Alexandrescu, "Three Optimization Tips for
# C++" (CppCon 2014, slide 50ff); also documented in fmt's `format_decimal`.
#
# Used by the fast formatters under `chrono/format/`. Private; outside callers
# do not import these.


# Two ASCII bytes per index — `_D100[2*n : 2*n+2]` is the zero-padded decimal
# encoding of `n` for `n in [0, 100)`.
comptime _D100: StaticString = (
    "00010203040506070809"
    "10111213141516171819"
    "20212223242526272829"
    "30313233343536373839"
    "40414243444546474849"
    "50515253545556575859"
    "60616263646566676869"
    "70717273747576777879"
    "80818283848586878889"
    "90919293949596979899"
)


@always_inline
def write2(p: UnsafePointer[UInt8, MutAnyOrigin], off: Int, n: Int):
    """Write two zero-padded ASCII digits of `n` at `p + off`. `n` must be
    `0..99`; bounds are the caller's contract."""
    var bytes = _D100.as_bytes()
    var idx = n + n
    p[off] = bytes[idx]
    p[off + 1] = bytes[idx + 1]


@always_inline
def write4(p: UnsafePointer[UInt8, MutAnyOrigin], off: Int, n: Int):
    """Write four zero-padded ASCII digits of `n` at `p + off`. `n` must be
    `0..9999`."""
    var hi = n // 100
    var lo = n - hi * 100
    write2(p, off, hi)
    write2(p, off + 2, lo)


@always_inline
def write_n_digits_padded(
    p: UnsafePointer[UInt8, MutAnyOrigin], off: Int, value: Int, n_digits: Int
):
    """Write `value` as exactly `n_digits` zero-padded ASCII digits at
    `p + off`. `value` must fit in `n_digits` decimal columns."""
    var v = value
    for i in range(n_digits - 1, -1, -1):
        p[off + i] = UInt8(ord("0")) + UInt8(v % 10)
        v //= 10
