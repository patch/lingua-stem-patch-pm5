package Lingua::Stem::Patch::EO;

use v5.8.1;
use utf8;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION   = '0.02';
our @EXPORT_OK = qw( stem stem_eo stem_aggressive stem_eo_aggressive );

*stem_eo            = \&stem;
*stem_eo_aggressive = \&stem_aggressive;

my %protect = (
    correlative => { map { $_ => 1 } map {
        my $start = $_;
        map { $start . $_ } qw( a al am e el es o om u )
    } qw( ki ti i ĉi neni ) },
    root => { map { $_ => 1 } qw(
        ĉar ĉi ĉu kaj ke la minus plus se
        ĉe da de el ekster en ĝis je kun na po pri pro sen tra
        ajn do ja jen ju ne pli tamen tre tro
        ci ĝi ili li mi ni oni ri si ŝi ŝli vi
        unu du tri kvin
        ĵus nun plu tuj
        amen bis boj fi ha he ho hu hura nu ve
    ) },
    noun => { map { $_ => 1 } qw(
        esperanto ganto horizonto kanto monto ponto rakonto
    ) },
);

sub stem {
    my ($word) = @_;

    $word = lc $word;

    # standalone roots
    return $word if $protect{root}{$word};

    # l’ l' → la
    return 'la'
        if $word =~ m{^ l [’'] $}x;

    # un’ un' unuj → unu
    return 'unu'
        if $word =~ m{^ un (?: [’'] | uj ) $}x;

    # -’ -' → -o
    $word =~ s{ [’'] $}{o}x;

    # nouns, adjectives, -u correlatives
    # -oj -on -ojn → o
    # -aj -an -ajn → a
    # -uj -un -ujn → u
    $word =~ s{ (?<= [aou] ) (?: [jn] | jn ) $}{}x;

    # accusative pronouns: -in → -i
    return $word
        if $word =~ s{ (?<= i ) n $}{}x;

    # correlatives: -en → -e
    $word =~ s{^ ( (?: [ĉkt] | nen )? ie ) n $}{$1}x;

    # correlative roots
    return $word if $protect{correlative}{$word};

    # verbs: -is -as -os -us -u → -i
    $word =~ s{ (?: [aiou] s | u ) $}{i}x;

    # compound verbs:
    # -inti -anti -onti -iti -ati -oti → -i
    # -inte -ante -onte -ite -ate -ote → -i
    # -inta -anta -onta -ita -ata -ota → -i
    $word =~ s{ (?: [aio] n? t ) [aei] $}{i}x;

    # accusative adverbs: -en → -o
    $word =~ s{ en $}{o}x;

    # lexical aspect: ek- el-
    $word =~ s{^ e [kl] }{}x;

    # imperfective verbs & action nouns: -adi -ado → -i
    return $word
        if $word =~ s{ ad [io] $}{i}x;

    # non-participle nouns
    return $word if $protect{noun}{$word};

    # participle nouns:
    # -into -anto -onto → -anto
    # -ito  -ato  -oto  → -ato
    return $word
        if $word =~ s{ [aio] ( n? ) to $}{a$1to}x;

    return $word;
}

sub stem_aggressive {
    my $stem = stem(shift);

    # protected words
    return $stem
        if $protect{root}{$stem}
        || $protect{correlative}{$stem};

    # remove final suffix
    $stem =~ s{ [aeio] $}{}x;

    return $stem;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::Patch::EO - Esperanto stemmer

=head1 VERSION

This document describes Lingua::Stem::Patch::EO v0.02.

=head1 SYNOPSIS

    use Lingua::Stem::Patch::EO qw( stem_eo );

    $stem = stem_eo($word);

    # alternate syntax
    $stem = Lingua::Stem::Patch::EO::stem($word);

=head1 DESCRIPTION

Light and aggressive stemmers for the universal language Esperanto. This is a
new project under active development and the current stemming algorithm is
likely to change.

This module provides the C<stem> and C<stem_eo> functions for the light stemmer,
which are synonymous and can optionally be exported, plus C<stem_aggressive> and
C<stem_eo_aggressive> functions for the aggressive stemmer. They accept a
character string for a word and return a character string for its stem.

=head1 SEE ALSO

L<Lingua::Stem::Patch> provides a stemming object with access to all of the
Patch stemmers including this one. It has additional features like stemming
lists of words.

L<Lingua::Stem::Any> provides a unified interface to any stemmer on CPAN,
including this one, as well as additional features like normalization,
casefolding, and in-place stemming.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2014 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
