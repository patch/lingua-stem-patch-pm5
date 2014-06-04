package Lingua::Stem::EO;

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

    # -oj -on -ojn -aj -an -ajn
    return $word
        if $word =~ s{ (?<= [ao] ) (?: [jn] | jn ) $}{}x;

    # -is -as -os -us -u
    return $word
        if $word =~ s{ (?: [aiou]s | u ) $}{i}x;

    # un’ un'
    return $word
        if $word =~ s{ (?<= \b un ) [’'] $}{u}x;

    # -’ -'
    return $word
        if $word =~ s{ [’'] $}{o}x;

    return $word;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::EO - Esperanto stemmer

=head1 VERSION

This document describes Lingua::Stem::EO v0.00_1.

=head1 SYNOPSIS

    use Lingua::Stem::EO qw( stem_eo );

    my $stem = stem_eo($word);

    # alternate syntax
    $stem = Lingua::Stem::EO::stem($word);

=head1 DESCRIPTION

A stemmer for the universal language Esperanto.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2014 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
