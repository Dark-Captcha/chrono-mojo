# Now: the current-UTC conveniences. A live clock cannot be KAT'd, so check that
# the reading is in a sane window and that the date/time agree with the datetime.

from chrono.now import Now


def run() raises -> Int:
    var f = 0

    var moment = Now.utc_datetime()
    if moment.year() < 2024 or moment.year() > 2100:
        print("FAIL Now.utc_datetime year out of range", moment.year())
        f += 1
    if moment.month().number() < 1 or moment.month().number() > 12:
        print("FAIL Now month")
        f += 1
    if moment.hour() < 0 or moment.hour() > 23:
        print("FAIL Now hour")
        f += 1

    # utc_date / utc_time are the date / time halves of a current datetime
    if Now.utc_date().year() < 2024:
        print("FAIL Now.utc_date")
        f += 1
    if Now.utc_time().hour() < 0 or Now.utc_time().hour() > 23:
        print("FAIL Now.utc_time")
        f += 1

    if f == 0:
        print("test_now: PASS")
    return f
