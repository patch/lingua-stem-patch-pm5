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
    return $word
        if $word =~ s{ (?<= [ao] ) (?: [jn] | jn ) $}{}x;

    # possessive adjectives
    # -in → -i
    return $word
        if $word =~ s{ (?<= i ) n $}{}x;

    # verbs
    # -int- -ant- -ont- -it- -at- -ot- (optional)
    # -is -as -os -us -u → -i
    return $word
        if $word =~ s{ (?: [aio] n? t )? (?: [aiou] s | u ) $}{i}x;

    # -inti -anti -onti -iti -ati -oti → -i
    # -inte -ante -onte -ite -ate -ote → -i
    return $word
        if $word =~ s{ (?: [aio] n? t ) [ei] $}{i}x;

    # un’ un' → unu
    return $word
        if $word =~ s{ (?<= \b un ) [’'] $}{u}x;

    # -’ -' → -o
    return $word
        if $word =~ s{ [’'] $}{o}x;

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

    my $stem = stem_eo($word);

    # alternate syntax
    $stem = Lingua::Stem::Patch::EO::stem($word);

=head1 DESCRIPTION

A stemmer for the universal language Esperanto.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2014 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
