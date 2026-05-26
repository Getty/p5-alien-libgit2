# Alien::Libgit2

Find or build [libgit2](https://libgit2.org/), the linkable Git library.

## Synopsis

```perl
use Alien::Libgit2;

# For XS consumers
my $cflags = Alien::Libgit2->cflags;
my $libs   = Alien::Libgit2->libs;

# For FFI consumers (FFI::Platypus, Git::Libgit2)
my @libs = Alien::Libgit2->dynamic_libs;
```

## Description

`Alien::Libgit2` provides the C library [libgit2](https://libgit2.org/) for use by
other CPAN modules that need to link against it.

It first checks whether a system `libgit2` (>= 1.5) is available via
`pkg-config`. If not, it builds libgit2 from a bundled source tarball using
CMake. No network access is required during install.

## Installation

```bash
cpanm Alien::Libgit2
```

Requires a libgit2 shared library (>= 1.5). If `pkg-config libgit2` is not
found, the module builds from the bundled libgit2-1.9.3 tarball using CMake.

### Build dependencies (share install)

- `cmake`
- C compiler
- `pkg-config`
- OpenSSL headers (HTTPS backend)
- libssh2 headers (SSH transport)

## Used by

- [Git::Libgit2](https://metacpan.org/pod/Git::Libgit2) — low-level FFI::Platypus
  bindings against libgit2
- [Git::Native](https://metacpan.org/pod/Git::Native) — high-level Moo wrapper on
  top of `Git::Libgit2`

## See also

- [Alien::Build](https://metacpan.org/pod/Alien::Build)
- [Alien::Base](https://metacpan.org/pod/Alien::Base)
- [libgit2](https://libgit2.org/)

## License

This software is copyright (c) 2026 by Torsten Raudssus.

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.