use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 199;
use Lingua::Stem::Patch::EO qw( stem_aggressive );

*stem = \&stem_aggressive;

is stem('kaj'),         'kaj',       'conjunction';
is stem('mi'),          'mi',        'personal pronoun';
is stem('min'),         'mi',        '-n accusative personal pronoun';
is stem('mia'),         'mi',        '-a possesive adjective';
is stem('miaj'),        'mi',        '-aj plural possesive adjective';
is stem('mian'),        'mi',        '-an accusative possesive adjective';
is stem('miajn'),       'mi',        '-ajn accusative plural possesive adjective';
is stem('hundo'),       'hund',      '-o noun';
is stem('hundoj'),      'hund',      '-oj plural noun';
is stem('hundon'),      'hund',     '-on accusative noun';
is stem('hundojn'),     'hund',     '-ojn accusative plural noun';
is stem('longa'),       'long',     '-a adjective';
is stem('longaj'),      'long',     '-aj plural adjective';
is stem('longan'),      'long',     '-an accusative adjective';
is stem('longajn'),     'long',     '-ajn accusative plural adjective';
is stem('labori'),      'labor',    '-i infinitive verb';
is stem('laboris'),     'labor',    '-is past indicative verb';
is stem('laboras'),     'labor',    '-as present indicative verb';
is stem('laboros'),     'labor',    '-os future indicative verb';
is stem('laborus'),     'labor',    '-us conditional verb';
is stem('laboru'),      'labor',    '-u jussive verb';
is stem('laborinti'),   'labor',    '-inti';
is stem('laboranti'),   'labor',    '-anti';
is stem('laboronti'),   'labor',    '-onti';
is stem('laboriti'),    'labor',    '-iti';
is stem('laborati'),    'labor',    '-ati';
is stem('laboroti'),    'labor',    '-oti';
is stem('laborintis'),  'labor',    '-intis';
is stem('laborantis'),  'labor',    '-antis';
is stem('laborontis'),  'labor',    '-ontis';
is stem('laboritis'),   'labor',    '-itis';
is stem('laboratis'),   'labor',    '-atis';
is stem('laborotis'),   'labor',    '-otis';
is stem('laborintas'),  'labor',    '-intas';
is stem('laborantas'),  'labor',    '-antas';
is stem('laborontas'),  'labor',    '-ontas';
is stem('laboritas'),   'labor',    '-itas';
is stem('laboratas'),   'labor',    '-atas';
is stem('laborotas'),   'labor',    '-otas';
is stem('laborintos'),  'labor',    '-intos';
is stem('laborantos'),  'labor',    '-antos';
is stem('laborontos'),  'labor',    '-ontos';
is stem('laboritos'),   'labor',    '-itos';
is stem('laboratos'),   'labor',    '-atos';
is stem('laborotos'),   'labor',    '-otos';
is stem('laborintus'),  'labor',    '-intus';
is stem('laborantus'),  'labor',    '-antus';
is stem('laborontus'),  'labor',    '-ontus';
is stem('laboritus'),   'labor',    '-itus';
is stem('laboratus'),   'labor',    '-atus';
is stem('laborotus'),   'labor',    '-otus';
is stem('laborintu'),   'labor',    '-intu';
is stem('laborantu'),   'labor',    '-antu';
is stem('laborontu'),   'labor',    '-ontu';
is stem('laboritu'),    'labor',    '-itu';
is stem('laboratu'),    'labor',    '-atu';
is stem('laborotu'),    'labor',    '-otu';
is stem('laborinte'),   'labor',    '-inte';
is stem('laborante'),   'labor',    '-ante';
is stem('laboronte'),   'labor',    '-onte';
is stem('laborite'),    'labor',    '-ite';
is stem('laborate'),    'labor',    '-ate';
is stem('laborote'),    'labor',    '-ote';
is stem('laborinta'),   'labor',    '-inta';
is stem('laboranta'),   'labor',    '-anta';
is stem('laboronta'),   'labor',    '-onta';
is stem('laborita'),    'labor',    '-ita';
is stem('laborata'),    'labor',    '-ata';
is stem('laborota'),    'labor',    '-ota';
is stem('laborintaj'),  'labor',    '-intaj';
is stem('laborantaj'),  'labor',    '-antaj';
is stem('laborontaj'),  'labor',    '-ontaj';
is stem('laboritaj'),   'labor',    '-itaj';
is stem('laborataj'),   'labor',    '-ataj';
is stem('laborotaj'),   'labor',    '-otaj';
is stem('laborintan'),  'labor',    '-intan';
is stem('laborantan'),  'labor',    '-antan';
is stem('laborontan'),  'labor',    '-ontan';
is stem('laboritan'),   'labor',    '-itan';
is stem('laboratan'),   'labor',    '-atan';
is stem('laborotan'),   'labor',    '-otan';
is stem('laborintajn'), 'labor',    '-intajn';
is stem('laborantajn'), 'labor',    '-antajn';
is stem('laborontajn'), 'labor',    '-ontajn';
is stem('laboritajn'),  'labor',    '-itajn';
is stem('laboratajn'),  'labor',    '-atajn';
is stem('laborotajn'),  'labor',    '-otajn';
is stem('laboradi'),    'labor',    '-adi';
is stem('laboradas'),   'labor',    '-adas';
is stem('laborado'),    'labor',    '-ado';
is stem('eklabori'),    'labor',    'ek-';
is stem('ellabori'),    'labor',    'el-';
is stem('laboranto'),   'laborant', '-anto';
is stem('laborinto'),   'laborant', '-into';
is stem('laboronto'),   'laborant', '-onto';
is stem('laborato'),    'laborat',  '-ato';
is stem('laborito'),    'laborat',  '-ito';
is stem('laboroto'),    'laborat',  '-oto';
is stem('esperanto'),   'esperant', 'esperanto: keep -anto';
is stem('kanto'),       'kant',     'kanto: keep -anto';
is stem('hund’'),       'hund',     '-’ noun with typographic apostrophe';
is stem("hund'"),       'hund',     "-' noun with typewriter apostrophe";
is stem('un’'),         'unu',      '-’ unu with typographic apostrophe';
is stem("un'"),         'unu',      "-' unu with typewriter apostrophe";

for my $start (qw{ ki ti i ĉi neni }) {
    for my $end (qw{ a al am e el es o om u }) {
        my $word = $start . $end;
        is stem($word), $word, "correlative: $word";

        if ($end eq 'a' || $end eq 'o' || $end eq 'u') {
            is stem($word . 'j'),  $word, "correlative: -${end}j";
            is stem($word . 'n'),  $word, "correlative: -${end}n";
            is stem($word . 'jn'), $word, "correlative: -${end}jn";
        }
        elsif ($end eq 'e') {
            is stem($word . 'n'), $word, 'correlative: -en';
        }
    }
}
