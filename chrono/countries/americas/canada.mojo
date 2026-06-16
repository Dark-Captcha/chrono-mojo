# Canada — ISO 3166-1 alpha-2 "CA". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.st_johns import ST_JOHNS
from chrono.timezones.america.halifax import HALIFAX
from chrono.timezones.america.glace_bay import GLACE_BAY
from chrono.timezones.america.moncton import MONCTON
from chrono.timezones.america.goose_bay import GOOSE_BAY
from chrono.timezones.america.toronto import TORONTO
from chrono.timezones.america.iqaluit import IQALUIT
from chrono.timezones.america.winnipeg import WINNIPEG
from chrono.timezones.america.resolute import RESOLUTE
from chrono.timezones.america.rankin_inlet import RANKIN_INLET
from chrono.timezones.america.regina import REGINA
from chrono.timezones.america.swift_current import SWIFT_CURRENT
from chrono.timezones.america.edmonton import EDMONTON
from chrono.timezones.america.cambridge_bay import CAMBRIDGE_BAY
from chrono.timezones.america.inuvik import INUVIK
from chrono.timezones.america.vancouver import VANCOUVER
from chrono.timezones.america.dawson_creek import DAWSON_CREEK
from chrono.timezones.america.fort_nelson import FORT_NELSON
from chrono.timezones.america.whitehorse import WHITEHORSE
from chrono.timezones.america.dawson import DAWSON
from chrono.timezones.america.panama import PANAMA
from chrono.timezones.america.puerto_rico import PUERTO_RICO
from chrono.timezones.america.phoenix import PHOENIX


struct Canada(ImplicitlyCopyable, Movable):
    """Canada — ISO 3166-1 alpha-2 'CA'."""

    comptime CODE = StaticString("CA")
    comptime NAME = StaticString("Canada")
    comptime FLAG = StaticString("🇨🇦")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("en_CA|fr_CA|ik_CA|iu_CA|shs_CA")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[239, 9],
        Timezone[228, 5],
        Timezone[140, 5],
        Timezone[207, 6],
        Timezone[204, 11],
        Timezone[233, 5],
        Timezone[135, 9],
        Timezone[186, 7],
        Timezone[133, 5],
        Timezone[133, 5],
        Timezone[53, 6],
        Timezone[23, 6],
        Timezone[150, 5],
        Timezone[137, 10],
        Timezone[133, 5],
        Timezone[168, 6],
        Timezone[58, 6],
        Timezone[143, 6],
        Timezone[93, 9],
        Timezone[93, 9],
        Timezone[2, 3],
        Timezone[4, 4],
        Timezone[11, 5],
    ]:
        return (
            ST_JOHNS,
            HALIFAX,
            GLACE_BAY,
            MONCTON,
            GOOSE_BAY,
            TORONTO,
            IQALUIT,
            WINNIPEG,
            RESOLUTE,
            RANKIN_INLET,
            REGINA,
            SWIFT_CURRENT,
            EDMONTON,
            CAMBRIDGE_BAY,
            INUVIK,
            VANCOUVER,
            DAWSON_CREEK,
            FORT_NELSON,
            WHITEHORSE,
            DAWSON,
            PANAMA,
            PUERTO_RICO,
            PHOENIX,
        )
