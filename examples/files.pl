#!/usr/local/bin/perl

use diagnostics;
use strict;
use warnings;
use Digest::Whirlpool;
use MIME::Base64;

my $file = "strings.pl";
open INFILE, $file;

my $whirlpool = new Digest::Whirlpool;
$whirlpool->addfile(*INFILE);
my $hex_output = $whirlpool->hexdigest();
my $base64_output = $whirlpool->base64digest();
close INFILE;
print "$file\n";
print "$hex_output\n";
print "$base64_output\n";

