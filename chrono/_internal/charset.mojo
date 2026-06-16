# ASCII byte constants — the shared character vocabulary of chrono's parsers, named
# once here instead of scattered `ord("-")` calls or bare numbers like `== 45`. `ord`
# of a literal is folded at compile time, so every constant below is a comptime Int
# with zero runtime cost; referencing `charset.COLON` compiles to the same code as
# the literal would, but reads as intent. Parsers compare `Int(byte) == charset.COLON`.

comptime DIGIT_ZERO = ord("0")
comptime DIGIT_NINE = ord("9")

comptime PLUS = ord("+")
comptime MINUS = ord("-")
comptime PERIOD = ord(".")


@always_inline
def is_digit(byte: Int) -> Bool:
    return DIGIT_ZERO <= byte <= DIGIT_NINE
