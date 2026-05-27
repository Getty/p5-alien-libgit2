# ABSTRACT: Find or build libgit2, the linkable Git library

package Alien::Libgit2;
our $VERSION = '0.002';
use strict;
use warnings;
use parent 'Alien::Base';

1;

=head1 SYNOPSIS

  use Alien::Libgit2;

  # For XS consumers
  my $cflags = Alien::Libgit2->cflags;
  my $libs   = Alien::Libgit2->libs;

  # For FFI consumers (FFI::Platypus, Git::Libgit2)
  my @libs = Alien::Libgit2->dynamic_libs;

=head1 DESCRIPTION

L<Alien::Libgit2> provides the C library L<libgit2|https://libgit2.org/>
for use by other CPAN modules that need to link against it.

It first checks whether a system C<libgit2> (>= 1.5) is available via
C<pkg-config>. If not, it builds libgit2 from a bundled source tarball
using CMake. No network access is required during install.

=head1 SEE ALSO

L<Git::Libgit2>, L<Git::Native>, L<Alien::Build>, L<Alien::Base>

=cut
