use diagnostics;
use strict;
use warnings;
use Test::More tests => 2;
BEGIN {
    use_ok('Digest::Whirlpool')
};

BEGIN {
    open INFILE, "t/file3.test";
    my $whirlpool = new Digest::Whirlpool;
    $whirlpool->addfile(*INFILE);
    my $digest = $whirlpool->hexdigest();
    is("8aca2602792aec6f11a67206531fb7d7f0dff59413145e6973c45001d0087b42d11bc645413aeff63a42391a39145a591a92200d560195e53b478584fdae231a",
        $digest);
};

