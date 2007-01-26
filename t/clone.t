use diagnostics;
use strict;
use warnings;
use Test::More tests => 4;
BEGIN {
    use_ok('Digest::Whirlpool')
};

BEGIN {
    my $whirlpool = new Digest::Whirlpool;
    $whirlpool->add("a");
    my $whirlpool2 = $whirlpool->clone;
    my $digest = $whirlpool->hexdigest();
    is("8aca2602792aec6f11a67206531fb7d7f0dff59413145e6973c45001d0087b42d11bc645413aeff63a42391a39145a591a92200d560195e53b478584fdae231a",
        $digest);

    # do this after the digest above to make sure we're not just
    # pointing to the same memory location
    $whirlpool2->add( "bc" );
    my $whirlpool3 = $whirlpool2->clone->clone->clone; # chaned cloning
    my $digest2 = $whirlpool2->hexdigest();
    is($digest2, "4e2448a4c6f486bb16b6562c73b4020bf3043e3a731bce721ae1b303d97e6d4c7181eebdb6c57e277d0e34957114cbd6c797fc9d95d8b582d225292076d4eef5");

    # do this after the digest above to make sure we're not just
    # pointing to the same memory location
    $whirlpool3->add( "de" );
    my $digest3 = $whirlpool3->hexdigest();
    is $digest3, "5d745e26ccb20fe655d39c9e7f69455758fbae541cb892b3581e4869244ab35b4fd6078f5d28b1f1a217452a67d9801033d92724a221255a5e377fe9e9e5f0b2";
};

