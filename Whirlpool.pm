package Digest::Whirlpool;

use strict;
use warnings;
use MIME::Base64;
require Exporter;

our @EXPORT_OK = qw(new hashsize reset add addfile digest hexdigest base64digest);
our $VERSION = '1.0.3';
our @ISA = qw(Exporter);

require XSLoader;
XSLoader::load('Digest::Whirlpool', $VERSION);

# Preloaded methods go here.

sub addfile
{
    my ($self, $handle) = @_;
    my ($package, $file, $line) = caller;

    if (!ref($handle)) {
        $handle = "$package::$handle" unless ($handle =~ /(\:\:|\')/);
    }

    while (read($handle, my $data, 1048576)) {
        $self->add($data);
    }
}

sub hexdigest
{
    my $self = shift;
    return unpack("H*", $self->digest());
}

sub base64digest
{
    my $self = shift;
    return encode_base64($self->digest(), "");
}

1;

__END__

=head1 NAME

Digest::Whirlpool - A 512-bit one-way hash function

=head1 ABSTRACT

Digest::Whirlpool - A 512-bit, collision-resistant, one-way hash
function developed by Paulo S. L. M. Barreto and Vincent Rijmen.

=head1 SYNOPSIS

    use Digest::Whirlpool;

    $whirlpool = new Digest::Whirlpool;
    $whirlpool->add(LIST);
    $whirlpool->addfile(*HANDLE);
    $whirlpool->reset();

    $digest = $whirlpool->digest();
    $digest = $whirlpool->hexdigest();
    $digest = $whirlpool->base64digest();
    
    $digest = $whirlpool->hashsize();

=head1 DESCRIPTION

Whirlpool is a 512-bit, collision-resistant, one-way hash
function designed by Paulo S. L. M. Barreto and Vincent Rijmen.
Whirlpool is the NESSIE winner for this category.

=head2 Functions

=over

=item B<hashsize()>

Returns the size (in bits) of the hash (512, in this case)

=item B<add(LIST)>

Hashes a string or a list of strings

=item B<addfile(*HANDLE)>

Hashes a file

=item B<reset()>

Re-initializes the hash state. Before calculating another digest, the
hash state must be refreshed.

=item B<digest()>

Generates the hash output (a 64-byte binary string)

=item B<hexdigest()>

Generates a hexadecimal representation of the hash output

=item B<base64digest()>

Generates a base64 representation of the hash output. B<MIME::Base64>
must be installed first for this function to work.

=back

=head1 EXAMPLE 1

    #!/usr/local/bin/perl

    use diagnostics;
    use strict;
    use warnings;
    use Digest::Whirlpool;

    my $string1 = "This is a string.";
    my $string2 = "This is another string.";
    my $string3 = "This is a string.This is another string.";

    my $whirlpool = new Digest::Whirlpool;
    print "hash size=", $whirlpool->hashsize, "\n";

    $whirlpool->add($string1);
    my $digest = $whirlpool->hexdigest();
    print "Hash string1 only\n";
    print "$digest\n\n";

    $whirlpool->reset();
    $whirlpool->add($string1, $string2);
    my $digest2 = $whirlpool->hexdigest();
    print "Hash string1 and then hash string2\n";
    print "$digest2\n\n";
    
    $whirlpool->reset();
    $whirlpool->add($string3);
    print "Hash the two concatenated strings\n";
    my $digest3 = $whirlpool->hexdigest();
    print "$digest3\n";

=head1 EXAMPLE 2

    #!/usr/local/bin/perl

    use diagnostics;
    use strict;
    use warnings;
    use MIME::Base64;
    use Digest::Whirlpool;

    my $file = "strings.pl";
    open INFILE, $file or die "$file not found";

    my $whirlpool = new Digest::Whirlpool;
    $whirlpool->addfile(*INFILE);
    my $hex_output = $whirlpool->hexdigest();
    my $base64_output = $whirlpool->base64digest();
    close INFILE;
    print "$file\n";
    print "$hex_output\n";
    print "$base64_output\n";

=head1 MORE EXAMPLES

See the "examples" and "t" directories for more examples.

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Julius C. Duque <jcduque (AT) lycos (DOT) com>

This library is free software; you can redistribute it and/or modify
it under the same terms as the GNU General Public License.

=cut

