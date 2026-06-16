# Etc/Greenwich — IANA Link to Etc/GMT (per tzdata.zi). Importing GREENWICH
# yields the SAME comptime object as GMT; no duplicate transition data.

from chrono.timezones.etc.gmt import GMT


comptime GREENWICH = GMT
