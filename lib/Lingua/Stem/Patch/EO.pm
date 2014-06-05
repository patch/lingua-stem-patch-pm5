package Lingua::Stem::Patch::EO;

use v5.8.1;
use utf8;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION   = '0.00_1';
our @EXPORT_OK = qw( stem stem_eo );

*stem_eo = \&stem;

sub stem {
    my ($word) = @_;

    $word = lc $word;

    # nouns and adjectives
    # -oj -on -ojn → o
    # -aj -an -ajn → a
    $word =~ s{ (?<= [ao] ) (?: [jn] | jn ) $}{}x;

    # un’ un' → unu
    return $word
        if $word =~ s{ (?<= \b un ) [’'] $}{u}x;

    # -’ -' → -o
    $word =~ s{ [’'] $}{o}x;

    # verbs
    # -is -as -os -us -u → -i
    $word =~ s{ (?: [aiou] s | u ) $}{i}x;

    # compound verbs
    # -inti -anti -onti -iti -ati -oti → -i
    # -inte -ante -onte -ite -ate -ote → -i
    # -inta -anta -onta -ita -ata -ota → -i
    $word =~ s{ (?: [aio] n? t ) [aei] $}{i}x;

    # lexical aspect
    # ek- el-
    $word =~ s{^ e [kl] }{}x;

    # imperfective verbs and action nouns
    # -adi -ado → -i
    return $word
        if $word =~ s{ ad [io] $}{i}x;

    # exceptions: not participle nouns
    return $word if $word =~ m{ \b (?:
        esperanto
        | ganto
        | horizonto
        | kanto
        | monto
        | ponto
        | rakonto
    ) $ }x;

    # participle nouns
    # -into -anto -onto → -anto
    # -ito  -ato  -oto  → -ato
    return $word
        if $word =~ s{ [aio] ( n? ) to $}{a$1to}x;

    # possessive adjectives
    # -in → -i
    return $word
        if $word =~ s{ (?<= i ) n $}{}x;

    return $word;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::Patch::EO - Esperanto stemmer

=head1 VERSION

This document describes Lingua::Stem::Patch::EO v0.00_1.

=head1 SYNOPSIS

    use Lingua::Stem::Patch::EO qw( stem_eo );

    $stem = stem_eo($word);

    # alternate syntax
    $stem = Lingua::Stem::Patch::EO::stem($word);

=head1 DESCRIPTION

A stemmer for the universal language Esperanto. This is a new project under
active development and the current stemming algorithm is likely to change.

This module provides the C<stem> and C<stem_eo> functions, which are synonymous
and can optionally be exported. They accept a single word and return a single
stem.

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
