# Backward-compat IANA Link aliases — every L row from tzdata.zi.
# Generated at build time from /usr/share/zoneinfo/tzdata.zi.
#
# Each alias is a comptime constant pointing at the SAME Timezone[N, T]
# instance as its canonical target — Mojo dedup makes the alias completely
# free (zero new memory). Import the alias directly, e.g.
# `from chrono.timezones.aliases import GB` — it IS the same object as
# `chrono.timezones.europe.london.LONDON`.

from chrono.timezones.africa.abidjan import ABIDJAN
from chrono.timezones.africa.cairo import CAIRO
from chrono.timezones.africa.johannesburg import JOHANNESBURG
from chrono.timezones.africa.lagos import LAGOS
from chrono.timezones.africa.maputo import MAPUTO
from chrono.timezones.africa.nairobi import NAIROBI
from chrono.timezones.africa.tripoli import TRIPOLI
from chrono.timezones.america.adak import ADAK
from chrono.timezones.america.anchorage import ANCHORAGE
from chrono.timezones.america.argentina_buenos_aires import (
    ARGENTINA_BUENOS_AIRES,
)
from chrono.timezones.america.argentina_catamarca import ARGENTINA_CATAMARCA
from chrono.timezones.america.argentina_cordoba import ARGENTINA_CORDOBA
from chrono.timezones.america.argentina_jujuy import ARGENTINA_JUJUY
from chrono.timezones.america.argentina_mendoza import ARGENTINA_MENDOZA
from chrono.timezones.america.chicago import CHICAGO
from chrono.timezones.america.denver import DENVER
from chrono.timezones.america.detroit import DETROIT
from chrono.timezones.america.edmonton import EDMONTON
from chrono.timezones.america.halifax import HALIFAX
from chrono.timezones.america.havana import HAVANA
from chrono.timezones.america.indiana_indianapolis import INDIANA_INDIANAPOLIS
from chrono.timezones.america.indiana_knox import INDIANA_KNOX
from chrono.timezones.america.iqaluit import IQALUIT
from chrono.timezones.america.kentucky_louisville import KENTUCKY_LOUISVILLE
from chrono.timezones.america.los_angeles import LOS_ANGELES
from chrono.timezones.america.manaus import MANAUS
from chrono.timezones.america.mazatlan import MAZATLAN
from chrono.timezones.america.mexico_city import MEXICO_CITY
from chrono.timezones.america.new_york import NEW_YORK
from chrono.timezones.america.noronha import NORONHA
from chrono.timezones.america.nuuk import NUUK
from chrono.timezones.america.panama import PANAMA
from chrono.timezones.america.phoenix import PHOENIX
from chrono.timezones.america.puerto_rico import PUERTO_RICO
from chrono.timezones.america.regina import REGINA
from chrono.timezones.america.rio_branco import RIO_BRANCO
from chrono.timezones.america.santiago import SANTIAGO
from chrono.timezones.america.sao_paulo import SAO_PAULO
from chrono.timezones.america.st_johns import ST_JOHNS
from chrono.timezones.america.tijuana import TIJUANA
from chrono.timezones.america.toronto import TORONTO
from chrono.timezones.america.vancouver import VANCOUVER
from chrono.timezones.america.whitehorse import WHITEHORSE
from chrono.timezones.america.winnipeg import WINNIPEG
from chrono.timezones.asia.ashgabat import ASHGABAT
from chrono.timezones.asia.bangkok import BANGKOK
from chrono.timezones.asia.dhaka import DHAKA
from chrono.timezones.asia.dubai import DUBAI
from chrono.timezones.asia.ho_chi_minh import HO_CHI_MINH
from chrono.timezones.asia.hong_kong import HONG_KONG
from chrono.timezones.asia.jerusalem import JERUSALEM
from chrono.timezones.asia.kathmandu import KATHMANDU
from chrono.timezones.asia.kolkata import KOLKATA
from chrono.timezones.asia.kuching import KUCHING
from chrono.timezones.asia.macau import MACAU
from chrono.timezones.asia.makassar import MAKASSAR
from chrono.timezones.asia.nicosia import NICOSIA
from chrono.timezones.asia.qatar import QATAR
from chrono.timezones.asia.riyadh import RIYADH
from chrono.timezones.asia.seoul import SEOUL
from chrono.timezones.asia.shanghai import SHANGHAI
from chrono.timezones.asia.singapore import SINGAPORE
from chrono.timezones.asia.taipei import TAIPEI
from chrono.timezones.asia.tehran import TEHRAN
from chrono.timezones.asia.thimphu import THIMPHU
from chrono.timezones.asia.tokyo import TOKYO
from chrono.timezones.asia.ulaanbaatar import ULAANBAATAR
from chrono.timezones.asia.urumqi import URUMQI
from chrono.timezones.asia.yangon import YANGON
from chrono.timezones.atlantic.faroe import FAROE
from chrono.timezones.australia.adelaide import ADELAIDE
from chrono.timezones.australia.brisbane import BRISBANE
from chrono.timezones.australia.broken_hill import BROKEN_HILL
from chrono.timezones.australia.darwin import DARWIN
from chrono.timezones.australia.hobart import HOBART
from chrono.timezones.australia.lord_howe import LORD_HOWE
from chrono.timezones.australia.melbourne import MELBOURNE
from chrono.timezones.australia.perth import PERTH
from chrono.timezones.australia.sydney import SYDNEY
from chrono.timezones.etc.gmt import GMT
from chrono.timezones.etc.utc import UTC
from chrono.timezones.europe.athens import ATHENS
from chrono.timezones.europe.belgrade import BELGRADE
from chrono.timezones.europe.berlin import BERLIN
from chrono.timezones.europe.brussels import BRUSSELS
from chrono.timezones.europe.chisinau import CHISINAU
from chrono.timezones.europe.dublin import DUBLIN
from chrono.timezones.europe.helsinki import HELSINKI
from chrono.timezones.europe.istanbul import ISTANBUL
from chrono.timezones.europe.kyiv import KYIV
from chrono.timezones.europe.lisbon import LISBON
from chrono.timezones.europe.london import LONDON
from chrono.timezones.europe.moscow import MOSCOW
from chrono.timezones.europe.paris import PARIS
from chrono.timezones.europe.prague import PRAGUE
from chrono.timezones.europe.rome import ROME
from chrono.timezones.europe.warsaw import WARSAW
from chrono.timezones.europe.zurich import ZURICH
from chrono.timezones.indian.maldives import MALDIVES
from chrono.timezones.pacific.auckland import AUCKLAND
from chrono.timezones.pacific.chatham import CHATHAM
from chrono.timezones.pacific.easter import EASTER
from chrono.timezones.pacific.guadalcanal import GUADALCANAL
from chrono.timezones.pacific.guam import GUAM
from chrono.timezones.pacific.honolulu import HONOLULU
from chrono.timezones.pacific.kanton import KANTON
from chrono.timezones.pacific.pago_pago import PAGO_PAGO
from chrono.timezones.pacific.port_moresby import PORT_MORESBY
from chrono.timezones.pacific.tarawa import TARAWA


comptime AFRICA_ACCRA = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_ADDIS_ABABA = NAIROBI  # -> Africa/Nairobi
comptime AFRICA_ASMARA = NAIROBI  # -> Africa/Nairobi
comptime AFRICA_ASMERA = NAIROBI  # -> Africa/Nairobi
comptime AFRICA_BAMAKO = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_BANGUI = LAGOS  # -> Africa/Lagos
comptime AFRICA_BANJUL = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_BLANTYRE = MAPUTO  # -> Africa/Maputo
comptime AFRICA_BRAZZAVILLE = LAGOS  # -> Africa/Lagos
comptime AFRICA_BUJUMBURA = MAPUTO  # -> Africa/Maputo
comptime AFRICA_CONAKRY = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_DAKAR = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_DAR_ES_SALAAM = NAIROBI  # -> Africa/Nairobi
comptime AFRICA_DJIBOUTI = NAIROBI  # -> Africa/Nairobi
comptime AFRICA_DOUALA = LAGOS  # -> Africa/Lagos
comptime AFRICA_FREETOWN = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_GABORONE = MAPUTO  # -> Africa/Maputo
comptime AFRICA_HARARE = MAPUTO  # -> Africa/Maputo
comptime AFRICA_KAMPALA = NAIROBI  # -> Africa/Nairobi
comptime AFRICA_KIGALI = MAPUTO  # -> Africa/Maputo
comptime AFRICA_KINSHASA = LAGOS  # -> Africa/Lagos
comptime AFRICA_LIBREVILLE = LAGOS  # -> Africa/Lagos
comptime AFRICA_LOME = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_LUANDA = LAGOS  # -> Africa/Lagos
comptime AFRICA_LUBUMBASHI = MAPUTO  # -> Africa/Maputo
comptime AFRICA_LUSAKA = MAPUTO  # -> Africa/Maputo
comptime AFRICA_MALABO = LAGOS  # -> Africa/Lagos
comptime AFRICA_MASERU = JOHANNESBURG  # -> Africa/Johannesburg
comptime AFRICA_MBABANE = JOHANNESBURG  # -> Africa/Johannesburg
comptime AFRICA_MOGADISHU = NAIROBI  # -> Africa/Nairobi
comptime AFRICA_NIAMEY = LAGOS  # -> Africa/Lagos
comptime AFRICA_NOUAKCHOTT = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_OUAGADOUGOU = ABIDJAN  # -> Africa/Abidjan
comptime AFRICA_PORTO_NOVO = LAGOS  # -> Africa/Lagos
comptime AFRICA_TIMBUKTU = ABIDJAN  # -> Africa/Abidjan
comptime AMERICA_ANGUILLA = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_ANTIGUA = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_ARGENTINA_COMODRIVADAVIA = ARGENTINA_CATAMARCA  # -> America/Argentina/Catamarca
comptime AMERICA_ARUBA = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_ATIKOKAN = PANAMA  # -> America/Panama
comptime AMERICA_ATKA = ADAK  # -> America/Adak
comptime AMERICA_BLANC_SABLON = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_BUENOS_AIRES = ARGENTINA_BUENOS_AIRES  # -> America/Argentina/Buenos_Aires
comptime AMERICA_CATAMARCA = ARGENTINA_CATAMARCA  # -> America/Argentina/Catamarca
comptime AMERICA_CAYMAN = PANAMA  # -> America/Panama
comptime AMERICA_CORAL_HARBOUR = PANAMA  # -> America/Panama
comptime AMERICA_CORDOBA = ARGENTINA_CORDOBA  # -> America/Argentina/Cordoba
comptime AMERICA_CRESTON = PHOENIX  # -> America/Phoenix
comptime AMERICA_CURACAO = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_DOMINICA = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_ENSENADA = TIJUANA  # -> America/Tijuana
comptime AMERICA_FORT_WAYNE = INDIANA_INDIANAPOLIS  # -> America/Indiana/Indianapolis
comptime AMERICA_GODTHAB = NUUK  # -> America/Nuuk
comptime AMERICA_GRENADA = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_GUADELOUPE = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_INDIANAPOLIS = INDIANA_INDIANAPOLIS  # -> America/Indiana/Indianapolis
comptime AMERICA_JUJUY = ARGENTINA_JUJUY  # -> America/Argentina/Jujuy
comptime AMERICA_KNOX_IN = INDIANA_KNOX  # -> America/Indiana/Knox
comptime AMERICA_KRALENDIJK = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_LOUISVILLE = KENTUCKY_LOUISVILLE  # -> America/Kentucky/Louisville
comptime AMERICA_LOWER_PRINCES = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_MARIGOT = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_MENDOZA = ARGENTINA_MENDOZA  # -> America/Argentina/Mendoza
comptime AMERICA_MONTREAL = TORONTO  # -> America/Toronto
comptime AMERICA_MONTSERRAT = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_NASSAU = TORONTO  # -> America/Toronto
comptime AMERICA_NIPIGON = TORONTO  # -> America/Toronto
comptime AMERICA_PANGNIRTUNG = IQALUIT  # -> America/Iqaluit
comptime AMERICA_PORT_OF_SPAIN = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_PORTO_ACRE = RIO_BRANCO  # -> America/Rio_Branco
comptime AMERICA_RAINY_RIVER = WINNIPEG  # -> America/Winnipeg
comptime AMERICA_ROSARIO = ARGENTINA_CORDOBA  # -> America/Argentina/Cordoba
comptime AMERICA_SANTA_ISABEL = TIJUANA  # -> America/Tijuana
comptime AMERICA_SHIPROCK = DENVER  # -> America/Denver
comptime AMERICA_ST_BARTHELEMY = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_ST_KITTS = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_ST_LUCIA = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_ST_THOMAS = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_ST_VINCENT = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_THUNDER_BAY = TORONTO  # -> America/Toronto
comptime AMERICA_TORTOLA = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_VIRGIN = PUERTO_RICO  # -> America/Puerto_Rico
comptime AMERICA_YELLOWKNIFE = EDMONTON  # -> America/Edmonton
comptime ANTARCTICA_DUMONTDURVILLE = PORT_MORESBY  # -> Pacific/Port_Moresby
comptime ANTARCTICA_MCMURDO = AUCKLAND  # -> Pacific/Auckland
comptime ANTARCTICA_SOUTH_POLE = AUCKLAND  # -> Pacific/Auckland
comptime ANTARCTICA_SYOWA = RIYADH  # -> Asia/Riyadh
comptime ARCTIC_LONGYEARBYEN = BERLIN  # -> Europe/Berlin
comptime ASIA_ADEN = RIYADH  # -> Asia/Riyadh
comptime ASIA_ASHKHABAD = ASHGABAT  # -> Asia/Ashgabat
comptime ASIA_BAHRAIN = QATAR  # -> Asia/Qatar
comptime ASIA_BRUNEI = KUCHING  # -> Asia/Kuching
comptime ASIA_CALCUTTA = KOLKATA  # -> Asia/Kolkata
comptime ASIA_CHOIBALSAN = ULAANBAATAR  # -> Asia/Ulaanbaatar
comptime ASIA_CHONGQING = SHANGHAI  # -> Asia/Shanghai
comptime ASIA_CHUNGKING = SHANGHAI  # -> Asia/Shanghai
comptime ASIA_DACCA = DHAKA  # -> Asia/Dhaka
comptime ASIA_HARBIN = SHANGHAI  # -> Asia/Shanghai
comptime ASIA_ISTANBUL = ISTANBUL  # -> Europe/Istanbul
comptime ASIA_KASHGAR = URUMQI  # -> Asia/Urumqi
comptime ASIA_KATMANDU = KATHMANDU  # -> Asia/Kathmandu
comptime ASIA_KUALA_LUMPUR = SINGAPORE  # -> Asia/Singapore
comptime ASIA_KUWAIT = RIYADH  # -> Asia/Riyadh
comptime ASIA_MACAO = MACAU  # -> Asia/Macau
comptime ASIA_MUSCAT = DUBAI  # -> Asia/Dubai
comptime ASIA_PHNOM_PENH = BANGKOK  # -> Asia/Bangkok
comptime ASIA_RANGOON = YANGON  # -> Asia/Yangon
comptime ASIA_SAIGON = HO_CHI_MINH  # -> Asia/Ho_Chi_Minh
comptime ASIA_TEL_AVIV = JERUSALEM  # -> Asia/Jerusalem
comptime ASIA_THIMBU = THIMPHU  # -> Asia/Thimphu
comptime ASIA_UJUNG_PANDANG = MAKASSAR  # -> Asia/Makassar
comptime ASIA_ULAN_BATOR = ULAANBAATAR  # -> Asia/Ulaanbaatar
comptime ASIA_VIENTIANE = BANGKOK  # -> Asia/Bangkok
comptime ATLANTIC_FAEROE = FAROE  # -> Atlantic/Faroe
comptime ATLANTIC_JAN_MAYEN = BERLIN  # -> Europe/Berlin
comptime ATLANTIC_REYKJAVIK = ABIDJAN  # -> Africa/Abidjan
comptime ATLANTIC_ST_HELENA = ABIDJAN  # -> Africa/Abidjan
comptime AUSTRALIA_ACT = SYDNEY  # -> Australia/Sydney
comptime AUSTRALIA_CANBERRA = SYDNEY  # -> Australia/Sydney
comptime AUSTRALIA_CURRIE = HOBART  # -> Australia/Hobart
comptime AUSTRALIA_LHI = LORD_HOWE  # -> Australia/Lord_Howe
comptime AUSTRALIA_NSW = SYDNEY  # -> Australia/Sydney
comptime AUSTRALIA_NORTH = DARWIN  # -> Australia/Darwin
comptime AUSTRALIA_QUEENSLAND = BRISBANE  # -> Australia/Brisbane
comptime AUSTRALIA_SOUTH = ADELAIDE  # -> Australia/Adelaide
comptime AUSTRALIA_TASMANIA = HOBART  # -> Australia/Hobart
comptime AUSTRALIA_VICTORIA = MELBOURNE  # -> Australia/Melbourne
comptime AUSTRALIA_WEST = PERTH  # -> Australia/Perth
comptime AUSTRALIA_YANCOWINNA = BROKEN_HILL  # -> Australia/Broken_Hill
comptime BRAZIL_ACRE = RIO_BRANCO  # -> America/Rio_Branco
comptime BRAZIL_DENORONHA = NORONHA  # -> America/Noronha
comptime BRAZIL_EAST = SAO_PAULO  # -> America/Sao_Paulo
comptime BRAZIL_WEST = MANAUS  # -> America/Manaus
comptime CET = BRUSSELS  # -> Europe/Brussels
comptime CST6CDT = CHICAGO  # -> America/Chicago
comptime CANADA_ATLANTIC = HALIFAX  # -> America/Halifax
comptime CANADA_CENTRAL = WINNIPEG  # -> America/Winnipeg
comptime CANADA_EASTERN = TORONTO  # -> America/Toronto
comptime CANADA_MOUNTAIN = EDMONTON  # -> America/Edmonton
comptime CANADA_NEWFOUNDLAND = ST_JOHNS  # -> America/St_Johns
comptime CANADA_PACIFIC = VANCOUVER  # -> America/Vancouver
comptime CANADA_SASKATCHEWAN = REGINA  # -> America/Regina
comptime CANADA_YUKON = WHITEHORSE  # -> America/Whitehorse
comptime CHILE_CONTINENTAL = SANTIAGO  # -> America/Santiago
comptime CHILE_EASTERISLAND = EASTER  # -> Pacific/Easter
comptime CUBA = HAVANA  # -> America/Havana
comptime EET = ATHENS  # -> Europe/Athens
comptime EST = PANAMA  # -> America/Panama
comptime EST5EDT = NEW_YORK  # -> America/New_York
comptime EGYPT = CAIRO  # -> Africa/Cairo
comptime EIRE = DUBLIN  # -> Europe/Dublin
comptime ETC_GMT_PLUS_0 = GMT  # -> Etc/GMT
comptime ETC_GMT_0 = GMT  # -> Etc/GMT
comptime ETC_GMT0 = GMT  # -> Etc/GMT
comptime ETC_GREENWICH = GMT  # -> Etc/GMT
comptime ETC_UCT = UTC  # -> Etc/UTC
comptime ETC_UNIVERSAL = UTC  # -> Etc/UTC
comptime ETC_ZULU = UTC  # -> Etc/UTC
comptime EUROPE_AMSTERDAM = BRUSSELS  # -> Europe/Brussels
comptime EUROPE_BELFAST = LONDON  # -> Europe/London
comptime EUROPE_BRATISLAVA = PRAGUE  # -> Europe/Prague
comptime EUROPE_BUSINGEN = ZURICH  # -> Europe/Zurich
comptime EUROPE_COPENHAGEN = BERLIN  # -> Europe/Berlin
comptime EUROPE_GUERNSEY = LONDON  # -> Europe/London
comptime EUROPE_ISLE_OF_MAN = LONDON  # -> Europe/London
comptime EUROPE_JERSEY = LONDON  # -> Europe/London
comptime EUROPE_KIEV = KYIV  # -> Europe/Kyiv
comptime EUROPE_LJUBLJANA = BELGRADE  # -> Europe/Belgrade
comptime EUROPE_LUXEMBOURG = BRUSSELS  # -> Europe/Brussels
comptime EUROPE_MARIEHAMN = HELSINKI  # -> Europe/Helsinki
comptime EUROPE_MONACO = PARIS  # -> Europe/Paris
comptime EUROPE_NICOSIA = NICOSIA  # -> Asia/Nicosia
comptime EUROPE_OSLO = BERLIN  # -> Europe/Berlin
comptime EUROPE_PODGORICA = BELGRADE  # -> Europe/Belgrade
comptime EUROPE_SAN_MARINO = ROME  # -> Europe/Rome
comptime EUROPE_SARAJEVO = BELGRADE  # -> Europe/Belgrade
comptime EUROPE_SKOPJE = BELGRADE  # -> Europe/Belgrade
comptime EUROPE_STOCKHOLM = BERLIN  # -> Europe/Berlin
comptime EUROPE_TIRASPOL = CHISINAU  # -> Europe/Chisinau
comptime EUROPE_UZHGOROD = KYIV  # -> Europe/Kyiv
comptime EUROPE_VADUZ = ZURICH  # -> Europe/Zurich
comptime EUROPE_VATICAN = ROME  # -> Europe/Rome
comptime EUROPE_ZAGREB = BELGRADE  # -> Europe/Belgrade
comptime EUROPE_ZAPOROZHYE = KYIV  # -> Europe/Kyiv
comptime GB = LONDON  # -> Europe/London
comptime GB_EIRE = LONDON  # -> Europe/London
comptime GMT_PLUS_0 = GMT  # -> Etc/GMT
comptime GMT_0 = GMT  # -> Etc/GMT
comptime GMT0 = GMT  # -> Etc/GMT
comptime GREENWICH = GMT  # -> Etc/GMT
comptime HST = HONOLULU  # -> Pacific/Honolulu
comptime HONGKONG = HONG_KONG  # -> Asia/Hong_Kong
comptime ICELAND = ABIDJAN  # -> Africa/Abidjan
comptime INDIAN_ANTANANARIVO = NAIROBI  # -> Africa/Nairobi
comptime INDIAN_CHRISTMAS = BANGKOK  # -> Asia/Bangkok
comptime INDIAN_COCOS = YANGON  # -> Asia/Yangon
comptime INDIAN_COMORO = NAIROBI  # -> Africa/Nairobi
comptime INDIAN_KERGUELEN = MALDIVES  # -> Indian/Maldives
comptime INDIAN_MAHE = DUBAI  # -> Asia/Dubai
comptime INDIAN_MAYOTTE = NAIROBI  # -> Africa/Nairobi
comptime INDIAN_REUNION = DUBAI  # -> Asia/Dubai
comptime IRAN = TEHRAN  # -> Asia/Tehran
comptime ISRAEL = JERUSALEM  # -> Asia/Jerusalem
comptime JAPAN = TOKYO  # -> Asia/Tokyo
comptime LIBYA = TRIPOLI  # -> Africa/Tripoli
comptime MET = BRUSSELS  # -> Europe/Brussels
comptime MST = PHOENIX  # -> America/Phoenix
comptime MST7MDT = DENVER  # -> America/Denver
comptime MEXICO_BAJANORTE = TIJUANA  # -> America/Tijuana
comptime MEXICO_BAJASUR = MAZATLAN  # -> America/Mazatlan
comptime MEXICO_GENERAL = MEXICO_CITY  # -> America/Mexico_City
comptime NZ = AUCKLAND  # -> Pacific/Auckland
comptime NZ_CHAT = CHATHAM  # -> Pacific/Chatham
comptime NAVAJO = DENVER  # -> America/Denver
comptime PRC = SHANGHAI  # -> Asia/Shanghai
comptime PST8PDT = LOS_ANGELES  # -> America/Los_Angeles
comptime PACIFIC_CHUUK = PORT_MORESBY  # -> Pacific/Port_Moresby
comptime PACIFIC_ENDERBURY = KANTON  # -> Pacific/Kanton
comptime PACIFIC_FUNAFUTI = TARAWA  # -> Pacific/Tarawa
comptime PACIFIC_JOHNSTON = HONOLULU  # -> Pacific/Honolulu
comptime PACIFIC_MAJURO = TARAWA  # -> Pacific/Tarawa
comptime PACIFIC_MIDWAY = PAGO_PAGO  # -> Pacific/Pago_Pago
comptime PACIFIC_POHNPEI = GUADALCANAL  # -> Pacific/Guadalcanal
comptime PACIFIC_PONAPE = GUADALCANAL  # -> Pacific/Guadalcanal
comptime PACIFIC_SAIPAN = GUAM  # -> Pacific/Guam
comptime PACIFIC_SAMOA = PAGO_PAGO  # -> Pacific/Pago_Pago
comptime PACIFIC_TRUK = PORT_MORESBY  # -> Pacific/Port_Moresby
comptime PACIFIC_WAKE = TARAWA  # -> Pacific/Tarawa
comptime PACIFIC_WALLIS = TARAWA  # -> Pacific/Tarawa
comptime PACIFIC_YAP = PORT_MORESBY  # -> Pacific/Port_Moresby
comptime POLAND = WARSAW  # -> Europe/Warsaw
comptime PORTUGAL = LISBON  # -> Europe/Lisbon
comptime ROC = TAIPEI  # -> Asia/Taipei
comptime ROK = SEOUL  # -> Asia/Seoul
comptime TURKEY = ISTANBUL  # -> Europe/Istanbul
comptime UCT = UTC  # -> Etc/UTC
comptime US_ALASKA = ANCHORAGE  # -> America/Anchorage
comptime US_ALEUTIAN = ADAK  # -> America/Adak
comptime US_ARIZONA = PHOENIX  # -> America/Phoenix
comptime US_CENTRAL = CHICAGO  # -> America/Chicago
comptime US_EAST_INDIANA = INDIANA_INDIANAPOLIS  # -> America/Indiana/Indianapolis
comptime US_EASTERN = NEW_YORK  # -> America/New_York
comptime US_HAWAII = HONOLULU  # -> Pacific/Honolulu
comptime US_INDIANA_STARKE = INDIANA_KNOX  # -> America/Indiana/Knox
comptime US_MICHIGAN = DETROIT  # -> America/Detroit
comptime US_MOUNTAIN = DENVER  # -> America/Denver
comptime US_PACIFIC = LOS_ANGELES  # -> America/Los_Angeles
comptime US_SAMOA = PAGO_PAGO  # -> Pacific/Pago_Pago
comptime UNIVERSAL = UTC  # -> Etc/UTC
comptime W_SU = MOSCOW  # -> Europe/Moscow
comptime WET = LISBON  # -> Europe/Lisbon
comptime ZULU = UTC  # -> Etc/UTC
