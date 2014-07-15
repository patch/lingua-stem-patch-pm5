use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 21;
use Lingua::Stem::Patch::IO qw( stem );

is stem('la'),      'la',      'article';
is stem('hundo'),   'hundo',   'noun';
is stem('hundi'),   'hundo',   'plural noun';
is stem('hundon'),  'hundo',   'accusative noun';
is stem('hundin'),  'hundo',   'accusative plural noun';
is stem('longa'),   'longa',   'adjective';
is stem('laborir'), 'laborar', 'past infinitive verb';
is stem('laborar'), 'laborar', 'present infinitive verb';
is stem('laboror'), 'laborar', 'future infinitive verb';
is stem('laboris'), 'laborar', 'past indicative verb';
is stem('laboras'), 'laborar', 'present indicative verb';
is stem('laboros'), 'laborar', 'future indicative verb';
is stem('laborus'), 'laborar', 'conditional verb';
is stem('laborez'), 'laborar', 'jussive verb';
is stem('labore'),  'labore',  'adverb';

for my $suffix (qw{ inta anta onta ita ata ota }) {
    is stem('labor' . $suffix), 'laborar', "-$suffix participle";
}
