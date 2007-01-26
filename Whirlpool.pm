package Digest::Whirlpool;
use strict;
use base qw< Digest::base >;

use XSLoader ();

our $VERSION = '1.0.4';

XSLoader::load __PACKAGE__, $VERSION;

# Pre-1.0.4 used base64digest, maintain API compatibility with it.
*base64digest = \&Digest::base::b64digest;

1;

__END__

=head1 NAME

Digest::Whirlpool - A 512-bit, collision-resistant, one-way hash function

=head1 ABSTRACT

WHIRLPOOL is a 512-bit, collision-resistant, one-way hash function
developed by Paulo S. L. M. Barreto and Vincent Rijmen. It has been
recommended by the NESSIE project (along with SHA-256/384/512) and
adopted as ISO/IEC 10118-3.

=head1 SYNOPSIS

    # Using L<Digest> (recommended)
    use Digest;

    my $whirlpool = Digest->new( 'Whirlpool' );

    # Get a hash and reset the object
    $whirlpool->add( "hash this" );
    my $hexdigest = $whirlpool->hexdigest;

    # Populate the object again, and clone it before getting the
    # digest to avoid resetting
    $whirlpool->add( "hash this" );
    my $b64digest = $whirlpool->clone->b64digest;
    $whirlpool->add( "add this to the hash" );


    # Using this module directly (same interface)
    use Digest::Whirlpool;
    my $whirlpool = Digest->new( 'Whirlpool' );
    $whirlpool->add( ... );
    ....

=head1 DESCRIPTION

Provides an interface to the WHIRLPOOL hash algorithm. This module
subclasses L<Digest::base> and can be used either directly or through
the L<Digest> meta-module. Using the latter is recommended.

=head1 METHODS

Since this module implements the standard L<Digest
interface|Digest/"OO INTERFACE"> and should be used through the
L<Digest> module you should look at that documentation for the general
interface, below is a description of methods that differ.

=head2 clone

Copy the internal state of the current object into a new object and
return it.

=head2 reset

Resets the object to the same internal state it was in when it was
constructed.

This works exactly like L</new> except it doesn't allocate new memory
for its internal state.

=head2 base64digest

An legacy alias for the B<b64digest> method which should be used
instead.

=head2 hashsize

Returns the size (in bits) of a WHIRLPOOL hash, i.e. 512.

=head1 EXAMPLES

See the F<examples> and F<t> directories for some examples.

=head1 SEE ALSO

NESSIE consortium, I<Portfolio of recommended cryptographic primitives>, February 27, 2003.

L<Digest>, L<http://paginas.terra.com.br/informatica/paulobarreto/WhirlpoolPage.html>

=head1 AUTHORS

E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avar@cpan.org> (current maintainer)

Julius C. Duque <jcduque (AT) lycos (DOT) com> (original author)

=head1 BUGS

Please report any bugs that aren't already listed at
L<http://rt.cpan.org/Dist/Display.html?Queue=Digest-Whirlpool> to
L<http://rt.cpan.org/Public/Bug/Report.html?Queue=Digest-Whirlpool>

n=head1 LICENSE

Copyright 2003 Julius C. Duque and 2007 E<AElig>var
ArnfjE<ouml>rE<eth> Bjarmason.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=cut

