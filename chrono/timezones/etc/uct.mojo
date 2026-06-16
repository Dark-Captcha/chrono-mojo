# Etc/UCT — IANA Link to Etc/UTC (per tzdata.zi). Importing UCT yields the
# SAME comptime object as UTC; no duplicate transition data.

from chrono.timezones.etc.utc import UTC


comptime UCT = UTC
