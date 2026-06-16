# Etc/GMT+0 — IANA Link to Etc/GMT (per tzdata.zi). Importing GMT_PLUS_0
# yields the SAME comptime object as GMT; no duplicate transition data.

from chrono.timezones.etc.gmt import GMT


comptime GMT_PLUS_0 = GMT
