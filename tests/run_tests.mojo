# Aggregates chrono's test suites; each module's run() returns its failure count
# (0 == pass). Grown family by family.
# Run: pixi run test   (or: mojo run -I . tests/run_tests.mojo)

import tests.core.test_civil
import tests.core.test_civil_batch
import tests.types.test_duration
import tests.types.test_instant
import tests.types.test_enums
import tests.types.test_date
import tests.types.test_time
import tests.types.test_datetime
import tests.types.test_builder
import tests.types.test_span
import tests.types.test_offset
import tests.types.test_offset_datetime
import tests.types.test_calendar
import tests.types.test_calendars
import tests.types.test_partials
import tests.types.test_natural
import tests.types.test_now
import tests.types.test_timezone_typed
import tests.format.test_rfc3339
import tests.format.test_asn1
import tests.format.test_strftime
import tests.format.test_rfc2822
import tests.format.test_iso_duration
import tests.tz.test_zoned
import tests.recurrence.test_rrule
import tests.test_api


def main() raises:
    var f = 0
    # _core engine
    f += tests.core.test_civil.run()
    f += tests.core.test_civil_batch.run()
    # value types
    f += tests.types.test_duration.run()
    f += tests.types.test_instant.run()
    f += tests.types.test_enums.run()
    f += tests.types.test_date.run()
    f += tests.types.test_time.run()
    f += tests.types.test_datetime.run()
    f += tests.types.test_builder.run()
    f += tests.types.test_span.run()
    f += tests.types.test_offset.run()
    f += tests.types.test_offset_datetime.run()
    f += tests.types.test_calendar.run()
    f += tests.types.test_calendars.run()
    f += tests.types.test_partials.run()
    f += tests.types.test_natural.run()
    f += tests.types.test_now.run()
    f += tests.types.test_timezone_typed.run()
    # serialization formats
    f += tests.format.test_rfc3339.run()
    f += tests.format.test_asn1.run()
    f += tests.format.test_strftime.run()
    f += tests.format.test_rfc2822.run()
    f += tests.format.test_iso_duration.run()
    # time zones
    f += tests.tz.test_zoned.run()
    # recurrence
    f += tests.recurrence.test_rrule.run()
    # public package surface
    f += tests.test_api.run()

    if f == 0:
        print("ALL CHRONO TESTS PASS")
        return
    # Raise so that `pixi run test` exits non-zero — without this, CI silently
    # accepts every test that reports a failure count > 0.
    raise Error(String(f) + " CHRONO TEST FAILURES")
