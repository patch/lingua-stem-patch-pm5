use utf8;
use strict;
use warnings;
use Test::More;

eval 'use Test::Pod::Coverage 1.00';
plan skip_all => 'Test::Pod::Coverage 1.00 not installed; skipping' if $@;

pod_coverage_ok('Lingua::Stem::Patch');
done_testing();
