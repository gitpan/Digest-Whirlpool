use diagnostics;
use strict;
use warnings;
use Test::More tests => 2;
BEGIN {
    use_ok('Digest::Whirlpool')
};

BEGIN {
    my $whirlpool = new Digest::Whirlpool;
    $whirlpool->add("");
    my $digest = $whirlpool->hexdigest();
    is("19fa61d75522a4669b44e39c1d2e1726c530232130d407f89afee0964997f7a73e83be698b288febcf88e3e03c4f0757ea8964e59b63d93708b138cc42a66eb3",
        $digest);
};

