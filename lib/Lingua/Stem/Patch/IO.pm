package Lingua::Stem::Patch::IO;

use v5.8.1;
use utf8;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION   = '0.00_1';
our @EXPORT_OK = qw( stem stem_io );

*stem_io = \&stem;

sub stem {
    my ($word) = @_;

    $word = lc $word;

    # -on -i -in
    return $word
        if $word =~ s{ (?: on | in? ) $}{o}x;

    # -ir -or -is -as -os -us -ez
    return $word
        if $word =~ s{ (?: [io]r | [aiou]s | ez ) $}{ar}x;

    return $word;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::IO - Ido stemmer

=head1 VERSION

This document describes Lingua::Stem::Patch::IO v0.00_1.

=head1 SYNOPSIS

    use Lingua::Stem::Patch::IO qw( stem_io );

    my $stem = stem_io($word);

    # alternate syntax
    $stem = Lingua::Stem::Patch::IO::stem($word);

=head1 DESCRIPTION

A stemmer for the universal language Ido.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2014 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
