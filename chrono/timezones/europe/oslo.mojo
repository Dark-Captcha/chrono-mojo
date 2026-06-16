# Europe/Oslo — IANA Link to Europe/Berlin (per tzdata.zi). Importing OSLO
# yields the SAME comptime object as BERLIN; no duplicate transition data.

from chrono.timezones.europe.berlin import BERLIN


comptime OSLO = BERLIN
