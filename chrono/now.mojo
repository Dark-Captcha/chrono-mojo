# Now — the current civil time, projected to UTC. Composes Instant.now() (the libc
# clock) with the UTC projection on DateTime, keeping the value types free of any
# clock/FFI dependency. For the same wall-clock projected through a named IANA
# zone, use `ZonedDateTime.now(<typed Timezone constant>)`.
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: a pure composition of `Instant.now()` + `DateTime.from_utc_instant`;
# both halves have their own KAT and differential coverage. `tests/types/
# test_now.mojo` confirms monotonic ≠ realtime at the type level and a non-trivial
# year is returned (no spurious epoch).

from chrono.datetime import DateTime
from chrono.date import Date
from chrono.time import Time
from chrono.instant import Instant


struct Now:
    @staticmethod
    def utc_datetime() raises -> DateTime:
        return DateTime.from_utc_instant(Instant.now())

    @staticmethod
    def utc_date() raises -> Date:
        return Now.utc_datetime().date()

    @staticmethod
    def utc_time() raises -> Time:
        return Now.utc_datetime().time()
