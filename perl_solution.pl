#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use List::Util qw(sum);
use List::MoreUtils qw(minmax);
use POSIX;
use File::Map 'map_file';
use Pod::Usage qw(pod2usage);
use Getopt::Long qw(GetOptions);

my $start = time(); #simplified benchmarking

################# START CLI processing ###############

my $man = 0;
my $help = 0;
my $file_name = '';
my $delimeter = ' ';

pod2usage("$0: No arguments were provided!") if ((@ARGV == 0) && (-t STDIN));

GetOptions('help|?' => \$help, 
					 'man' => \$man,
					 'file|f=s' => \$file_name,
					 'delimeter|d:s' => \&parseDelim) or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-verbose => 2) if $man;

if ($file_name eq '') { 
	die "Provide the file that should be processed!";
}

sub parseDelim {
	my ($opt_name, $opt_value) = @_;
	$delimeter = qr/$opt_value/;
  return;
}

################# END CLI processing #################

################# START MAIN program #################

map_file my $file, $file_name, '<'; #memory mapping contents of the file

my @numbers = split($delimeter, $file);

my ($min, $max) = minmax @numbers;

my $sum = sum @numbers;
my $average = $sum / ($#numbers + 1);

my @res = sort { $a <=> $b } @numbers;
my $length = $#res + 1;
my $med = floor($length / 2);

if ($length % 2 == 0) {
	$med = ($res[$med] + $res[($med) - 1]) / 2;
} else {
	$med = $res[$med];
}

################# END MAIN program ###################

################# START RESULT output ################

my $end = time();

print "+--------------------------+\n";
print "|          RESULTS         |\n";
print "+--------------------------+\n";
print "  MAX => | $max \n";
print "+--------------------------+\n";
print "  MIN => | $min \n";
print "+--------------------------+\n";
print "  MED => | $med \n";
print "+--------------------------+\n";
print "  AVG => | $average \n";
print "+--------------------------+\n";
print "  TIME => | ", ($end - $start), " seconds \n";
print "+--------------------------+\n";

################# END RESULT output ##################

################# SECTION FOR THE POD ################
__END__
=head1 NAME

perl_solution - Calculates min, max, median, 
average for a given array of integers.

=head1 SYNOPSIS

perl_solution [-help|-man] -file [-delimiter]

=head1 OPTIONS

=over 4

=item B<-help, --help>

Prints a brief help message and exits.

=item B<-man, --man>

Prints the manual page and exits.

=item B<-file, --file, -f> -> REQUIRED

Specifies the file with integers which will be processed.

=item B<-delimeter, --delimeter, -d>

Delimeter pattern which will be used to parse a file (-file) and delimit integers in it.

Default is - any kind of space including newlines and tabs (regular expression /\s+/).

Use with caution! Example: if you want a pattern to be '/\s+/', then you should write: 'd=\s+'.

=back
    
=head1 DESCRIPTION

Perl solution for the test assignment provided by PortaOne
as a part of the 'Become a Developer' course attendants selection.

Returns values of min, max, median, average for the given file (-file), if possible.

=head1 AUTHOR

Implemented by Igor Vivdich in 2019.

=head1 AVAILABILITY

Please refer to the github repository: I<> for the details and implementation.
=cut