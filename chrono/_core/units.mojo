# Shared time-unit + range constants — the one place the conversion factors and
# integer bounds live, so they are never re-transcribed (or allowed to drift) across
# duration / time / datetime / timezone / date / partials. Each is derived from the previous
# so the relationships are self-evident and cannot be internally inconsistent. All are
# `comptime` (zero runtime cost).

comptime NANOS_PER_MICRO = 1_000
comptime NANOS_PER_MILLI = 1_000 * NANOS_PER_MICRO
comptime NANOS_PER_SECOND = 1_000 * NANOS_PER_MILLI
comptime MICROS_PER_SECOND = 1_000_000
comptime MILLIS_PER_SECOND = 1_000

comptime SECONDS_PER_MINUTE = 60
comptime MINUTES_PER_HOUR = 60
comptime SECONDS_PER_HOUR = SECONDS_PER_MINUTE * MINUTES_PER_HOUR
comptime HOURS_PER_DAY = 24
comptime SECONDS_PER_DAY = SECONDS_PER_HOUR * HOURS_PER_DAY  # 86_400

comptime NANOS_PER_MINUTE = SECONDS_PER_MINUTE * NANOS_PER_SECOND
comptime NANOS_PER_HOUR = SECONDS_PER_HOUR * NANOS_PER_SECOND
comptime NANOS_PER_DAY = SECONDS_PER_DAY * NANOS_PER_SECOND

comptime MONTHS_PER_YEAR = 12
comptime DAYS_PER_WEEK = 7

# Gregorian "400-year era" quantities (Hinnant) shared by the scalar and SIMD cores.
comptime DAYS_PER_ERA = 146_097  # days in a 400-year Gregorian era
comptime EPOCH_SHIFT_DAYS = 719_468  # 0000-03-01 .. 1970-01-01 (Hinnant's shift)

# Bounds of the Int32 day/year counts that Date / YearMonth store.
comptime INT32_MIN = -2_147_483_648
comptime INT32_MAX = 2_147_483_647

# Upper bound of the Int64 second counts that Duration stores. The matching
# lower bound is `-INT64_MAX - 1` (i.e. Int64.MIN) and is never spelled out as
# a comptime literal — Duration's overflow checks use `INT64_MAX // scale` and
# the symmetric `|value| <= limit` bound rejects `Int64.MIN`'s extra ulp.
comptime INT64_MAX = 9_223_372_036_854_775_807
