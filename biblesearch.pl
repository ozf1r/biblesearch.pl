#!/usr/bin/perl
# biblesearch.pl - diatheke search made easy
# for all Bible hackers
#
# 2.2.2024 Late@Linuxrauta.fi
#
# Public Domain
#
# Usage:
#
# biblesearch.pl range module search_string
#
# You need diatheke and the sword library installed
#

use strict;
use warnings;
my $range;
my $module;
my $search;
my $total;

# Check if exactly three arguments are given
if (scalar(@ARGV) == 3) {
    ($range, $module, $search) = @ARGV;
} else {
    die "Usage: biblesearch.pl <range> <module> <search>\n";
}

print "Searching: " . $search . "\n";
print "Range: " . $range . "\n";
print "Module: " . $module . "\n";

# Call diatheke and capture its output
my $output = `diatheke -b $module -s phrase -r $range -k $search`;

my @verses;

while ($output =~ /((?:\w+\s+){1,4})(\d+:\d+)/g) {
    my $verse_string = "$1 $2";
    push @verses, $verse_string;	
}

while ($output =~ /(\d+)\s+matches\s+total/g) {
    $total = $1;	
}

# Print the extracted Bible verses
print "Bible Verses:\n";
foreach my $verse (@verses) {

    my $output = `diatheke -b $module -k $verse`;

    print $output . "\n";	
}

if ($total) {
    print $total . " verses found\n";
} else {
	print "No verses found.\n";	
}
