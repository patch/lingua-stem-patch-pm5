[![Build status](https://travis-ci.org/patch/lingua-stem-patch-pm5.png)](https://travis-ci.org/patch/lingua-stem-patch-pm5)
[![Coverage status](https://coveralls.io/repos/patch/lingua-stem-patch-pm5/badge.png)](https://coveralls.io/r/patch/lingua-stem-patch-pm5)
[![CPAN version](https://badge.fury.io/pl/Lingua-Stem-Patch.png)](http://badge.fury.io/pl/Lingua-Stem-Patch)

# NAME

Lingua::Stem::Patch - Patch stemmers

# VERSION

This document describes Lingua::Stem::Patch v0.02.

# SYNOPSIS

```perl
use Lingua::Stem::Patch;

# create Esperanto stemmer
$stemmer = Lingua::Stem::Patch->new(language => 'eo');

# get stem for word
$stem = $stemmer->stem($word);

# get list of stems for list of words
@stems = $stemmer->stem(@words);
```

# DESCRIPTION

This module contains a collection of stemmers for multiple languages using the
Patch stemming algorithms. The languages currently implemented are
[Esperanto](https://metacpan.org/pod/Lingua::Stem::Patch::EO) and [Ido](https://metacpan.org/pod/Lingua::Stem::Patch::IO).

This is a new project under active development and the current stemming
algorithms are likely to change.

## Attributes

- language

    The following language codes are currently supported.

        ┌───────────┬────┐
        │ Esperanto │ eo │
        │ Ido       │ io │
        └───────────┴────┘

    They are in the two-letter ISO 639-1 format and are case-insensitive but are
    always returned in lowercase when requested.

    ```perl
    # instantiate a stemmer object
    $stemmer = Lingua::Stem::Patch->new(language => $language);

    # get current language
    $language = $stemmer->language;

    # change language
    $stemmer->language($language);
    ```

- aggressive

    By default a light stemmer will be used, but when `aggressive` is set to true,
    an aggressive stemmer will be used instead.

    ```perl
    $stemmer->aggressive(1);
    ```

## Methods

- stem

    Accepts a list of words, stems each word, and returns a list of stems. The list
    returned will always have the same number of elements in the same order as the
    list provided. When no stemming rules apply to a word, the original word is
    returned.

    ```perl
    @stems = $stemmer->stem(@words);

    # get the stem for a single word
    $stem = $stemmer->stem($word);
    ```

    The words should be provided as character strings and the stems are returned as
    character strings. Byte strings in arbitrary character encodings are
    intentionally not supported.

- languages

    Returns a list of supported two-letter language codes using lowercase letters.

    ```perl
    # object method
    @languages = $stemmer->languages;

    # class method
    @languages = Lingua::Stem::Patch->languages;
    ```

# SEE ALSO

[Lingua::Stem::Any](https://metacpan.org/pod/Lingua::Stem::Any) provides a unified interface to any stemmer on CPAN,
including this module, as well as additional features like normalization,
casefolding, and in-place stemming.

# AUTHOR

Nick Patch <patch@cpan.org>

# COPYRIGHT AND LICENSE

© 2014 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
