use diagnostics;
use strict;
use warnings;
use Test::More tests => 2;
BEGIN {
    use_ok('Digest::Whirlpool')
};

BEGIN {
    my $whirlpool = new Digest::Whirlpool;
    $whirlpool->add("abcdbcdecdefdefgefghfghighijhijk");
    my $digest = $whirlpool->hexdigest();
    is("2a987ea40f917061f5d6f0a0e4644f488a7a5a52deee656207c562f988e95c6916bdc8031bc5be1b7b947639fe050b56939baaa0adff9ae6745b7b181c3be3fd",
        $digest);
};

