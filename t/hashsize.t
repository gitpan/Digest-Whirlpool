use strict;
use warnings;

use Test::More tests => 1;

use Digest::Whirlpool qw< hashsize >;

#cmp_ok(hashsize(), '==', 512, 'hashsize');
cmp_ok(Digest::Whirlpool->new->hashsize, '==', 512, 'hashsize: OO');


