use diagnostics;
use strict;
use warnings;
use Test::More tests => 3;
BEGIN {
    use_ok('Digest::Whirlpool')
};

BEGIN {
    my $whirlpool = new Digest::Whirlpool;
    $whirlpool->add("a");
    my $whirlpool2 = $whirlpool->clone;

    for my $meth (qw< base64digest b64digest >) {
        my $digest = $whirlpool->clone->$meth();
        is( $digest, "isomAnkq7G8RpnIGUx+31/Df9ZQTFF5pc8RQAdAIe0LRG8ZFQTrv9jpCORo5FFpZGpIgDVYBleU7R4WE/a4jGg" );
    }
};

