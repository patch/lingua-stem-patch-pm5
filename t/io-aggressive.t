use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 14;
use Lingua::Stem::Patch::IO qw( stem_aggressive );

*stem = \&stem_aggressive;

is stem('la'),      'la',    'article';
is stem('hundo'),   'hund',  'noun';
is stem('hundi'),   'hund',  'plural noun';
is stem('hundon'),  'hund',  'accusative noun';
is stem('hundin'),  'hund',  'accusative plural noun';
is stem('longa'),   'long',  'adjective';
is stem('laborir'), 'labor', 'past infinitive verb';
is stem('laborar'), 'labor', 'present infinitive verb';
is stem('laboror'), 'labor', 'future infinitive verb';
is stem('laboris'), 'labor', 'past indicative verb';
is stem('laboras'), 'labor', 'present indicative verb';
is stem('laboros'), 'labor', 'future indicative verb';
is stem('laborus'), 'labor', 'conditional verb';
is stem('laborez'), 'labor', 'jussive verb';
