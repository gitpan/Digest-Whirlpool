use diagnostics;
use strict;
use warnings;
use Test::More tests => 2;
BEGIN {
    use_ok('Digest::Whirlpool')
};

BEGIN {
    open INFILE, "t/file1.test";
    my $whirlpool = new Digest::Whirlpool;
    $whirlpool->addfile(*INFILE);
    close INFILE;
    my $digest = $whirlpool->hexdigest();
    is("f1d754662636ffe92c82ebb9212a484a8d38631ead4238f5442ee13b8054e41b08bf2a9251c30b6a0b8aae86177ab4a6f68f673e7207865d5d9819a3dba4eb3b",
        $digest);
};

