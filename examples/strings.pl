#!/usr/local/bin/perl

use diagnostics;
use strict;
use warnings;
use Digest::Whirlpool;

my $string1 = "This is a string.";
my $string2 = "This is another string.";
my $string3 = "This is a string.This is another string.";
my $string4 = "a";

my $testdigest = "8aca2602792aec6f11a67206531fb7d7f0dff59413145e6973c45001d0087b42d11bc645413aeff63a42391a39145a591a92200d560195e53b478584fdae231a";

my $whirlpool = new Digest::Whirlpool;
print "hash size=", $whirlpool->hashsize, "\n";

$whirlpool->add($string1);
my $digest = $whirlpool->hexdigest();
print "1. Hash string1 only\n";
print "$digest\n\n";

$whirlpool->reset();
$whirlpool->add($string1, $string2);
my $digest2 = $whirlpool->hexdigest();
print "2. Hash string1 and then hash string2\n";
print "$digest2\n\n";

$whirlpool->reset();
$whirlpool->add($string3);
print "3. Hash the two concatenated strings\n";
my $digest3 = $whirlpool->hexdigest();
print "$digest3\n\n";

$whirlpool->reset();
$whirlpool->add($string4);
print "4. Hash test string\n";
my $digest4 = $whirlpool->hexdigest();
print "Whirlpool hash OK\n\n" if ($digest4 eq $testdigest);

$whirlpool->reset();
$whirlpool->add($string1);
$whirlpool->add($string2);
print "5. Hash the two concatenated strings\n";
my $digest5 = $whirlpool->hexdigest();
print "$digest5\n\n";

