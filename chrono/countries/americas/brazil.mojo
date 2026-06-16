# Brazil — ISO 3166-1 alpha-2 "BR". Generated from IANA + glibc data.
# Source-of-truth in this file; comptime-baked, no runtime I/O.

from chrono.continent import Continent
from chrono.timezone import Timezone
from chrono.timezones.america.noronha import NORONHA
from chrono.timezones.america.belem import BELEM
from chrono.timezones.america.fortaleza import FORTALEZA
from chrono.timezones.america.recife import RECIFE
from chrono.timezones.america.araguaina import ARAGUAINA
from chrono.timezones.america.maceio import MACEIO
from chrono.timezones.america.bahia import BAHIA
from chrono.timezones.america.sao_paulo import SAO_PAULO
from chrono.timezones.america.campo_grande import CAMPO_GRANDE
from chrono.timezones.america.cuiaba import CUIABA
from chrono.timezones.america.santarem import SANTAREM
from chrono.timezones.america.porto_velho import PORTO_VELHO
from chrono.timezones.america.boa_vista import BOA_VISTA
from chrono.timezones.america.manaus import MANAUS
from chrono.timezones.america.eirunepe import EIRUNEPE
from chrono.timezones.america.rio_branco import RIO_BRANCO


struct Brazil(ImplicitlyCopyable, Movable):
    """Brazil — ISO 3166-1 alpha-2 'BR'."""

    comptime CODE = StaticString("BR")
    comptime NAME = StaticString("Brazil")
    comptime FLAG = StaticString("🇧🇷")
    comptime CONTINENT = Continent.AMERICAS
    comptime LOCALES = StaticString("pt_BR")

    @staticmethod
    @always_inline
    def zones() -> Tuple[
        Timezone[39, 3],
        Timezone[29, 3],
        Timezone[39, 3],
        Timezone[39, 3],
        Timezone[51, 3],
        Timezone[41, 3],
        Timezone[61, 3],
        Timezone[91, 3],
        Timezone[91, 3],
        Timezone[89, 3],
        Timezone[30, 4],
        Timezone[29, 3],
        Timezone[33, 3],
        Timezone[31, 3],
        Timezone[33, 5],
        Timezone[31, 5],
    ]:
        return (
            NORONHA,
            BELEM,
            FORTALEZA,
            RECIFE,
            ARAGUAINA,
            MACEIO,
            BAHIA,
            SAO_PAULO,
            CAMPO_GRANDE,
            CUIABA,
            SANTAREM,
            PORTO_VELHO,
            BOA_VISTA,
            MANAUS,
            EIRUNEPE,
            RIO_BRANCO,
        )
