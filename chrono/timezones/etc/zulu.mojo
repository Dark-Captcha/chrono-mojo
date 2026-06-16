# Etc/Zulu — IANA Link to Etc/UTC (per tzdata.zi). Importing ZULU yields the
# SAME comptime object as UTC; no duplicate transition data.

from chrono.timezones.etc.utc import UTC


comptime ZULU = UTC
