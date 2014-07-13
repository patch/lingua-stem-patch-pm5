package Lingua::Stem::Patch::IO;

use v5.8.1;
use utf8;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION   = '0.01';
our @EXPORT_OK = qw( stem stem_io stem_aggressive stem_io_aggressive );

*stem_io            = \&stem;
*stem_io_aggressive = \&stem_aggressive;

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

sub stem_aggressive {
    my $stem = stem(shift);

    # remove final suffix
    $stem =~ s{ (?: [aeo] | ar ) $}{}x;

    return $stem;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::IO - Ido stemmer

=head1 VERSION

This document describes Lingua::Stem::Patch::IO v0.01.

=head1 SYNOPSIS

    use Lingua::Stem::Patch::IO qw( stem_io );

    $stem = stem_io($word);

    # alternate syntax
    $stem = Lingua::Stem::Patch::IO::stem($word);

=head1 DESCRIPTION

Light and aggressive stemmers for the universal language Ido. This is a new
project under active development and the current stemming algorithm is likely to
change.

This module provides the C<stem> and C<stem_io> functions for the light stemmer,
which are synonymous and can optionally be exported, plus C<stem_aggressive> and
C<stem_io_aggressive> functions for the aggressive stemmer. They accept a
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
