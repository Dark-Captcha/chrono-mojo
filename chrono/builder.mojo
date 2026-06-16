# DateTimeBuilder — a fluent way to assemble a DateTime field by field, validating
# only at build(). Each setter consumes and returns self (`var self` + `return self^`),
# so calls chain: DateTimeBuilder().year(2026).month(6).day(15).build(). Unset fields
# default to the epoch (1970-01-01 00:00:00), so a partial chain is still valid.
#
# Facets: tier T0 (spine) | safety sound (build validates via DateTime) | quantum n/a.
# Honesty: a thin assembler over DateTime; build() raises on any out-of-range field.

from chrono.datetime import DateTime


struct DateTimeBuilder(ImplicitlyCopyable, Movable):
    var _year: Int
    var _month: Int
    var _day: Int
    var _hour: Int
    var _minute: Int
    var _second: Int
    var _nanosecond: Int

    def __init__(out self):
        self._year = 1970
        self._month = 1
        self._day = 1
        self._hour = 0
        self._minute = 0
        self._second = 0
        self._nanosecond = 0

    def year(var self, year: Int) -> Self:
        self._year = year
        return self^

    def month(var self, month: Int) -> Self:
        self._month = month
        return self^

    def day(var self, day: Int) -> Self:
        self._day = day
        return self^

    def hour(var self, hour: Int) -> Self:
        self._hour = hour
        return self^

    def minute(var self, minute: Int) -> Self:
        self._minute = minute
        return self^

    def second(var self, second: Int) -> Self:
        self._second = second
        return self^

    def nanosecond(var self, nanosecond: Int) -> Self:
        self._nanosecond = nanosecond
        return self^

    def build(self) raises -> DateTime:
        """Validate the accumulated fields and produce the DateTime; raises on any
        out-of-range field (e.g. month 13 or February 30)."""
        return DateTime(
            self._year,
            self._month,
            self._day,
            self._hour,
            self._minute,
            self._second,
            self._nanosecond,
        )
