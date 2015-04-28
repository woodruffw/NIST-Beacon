package NIST::Beacon::Record;

use strict;
use warnings;

# ABSTRACT: A Record object used by NIST::Beacon to represent received data.

use Moo;

has 'version' => (is => 'ro');
has 'frequency' => (is => 'ro');
has 'timestamp' => (is => 'ro');
has 'seed' => (is => 'ro');
has 'previous' => (is => 'ro');
has 'signature' => (is => 'ro');
has 'current' => (is => 'ro');
has 'status' => (is => 'ro');


sub BUILD {
	my $self = shift;
	my $param = shift;

	$self->{version} = $param->{version};
	$self->{frequency} = $param->{frequency};
	$self->{timestamp} = $param->{timeStamp};
	$self->{seed} = $param->{seedValue};
	$self->{previous} = $param->{previousOutputValue};
	$self->{signature} = $param->{signatureValue};
	$self->{current} = $param->{outputValue};
	$self->{status} = $param->{statusCode};
}

1;

__END__

=pod

=head1 NAME

NIST::Beacon::Record - A Record object used by NIST::Beacon to represent received data.

=head1 VERSION

version 1.002

=head1 SYNOPSIS

	use NIST::Beacon;

	my $beacon = NIST::Beacon->new;
	my $record = $beacon->latest_record;

	print "The latest sequence generated by the NIST beacon is: \n";
	print $record->current, "\n";

=head1 DESCRIPTION

NIST::Beacon::Record objects are returned by the record methods in
L<NIST::Beacon>. They contain a variety of data from each emittance,
including version number, seed value, generation timestamp, and more.

=head2 methods

=over 12

=item C<< version >>

Returns the version of the beacon's schema.

=item C<< frequency >>

Returns the interval, in seconds, between beacon emittances.
For example, if C<< $record->frequency >> is 60, new records are emitted
every 60 seconds.

=item C<< timestamp >>

Returns the Unix timestamp associated with the moment of generation.

=item C<< seed >>

Returns a seed value represented as a 64 byte (512-bit) hex string value.

=item C<< previous >>

Returns the SHA-512 hash value for the previous record, as a 64 byte hex string.

=item C<< signature >>

Returns a digital signature (RSA) computed over (in order):
version, frequency, timestamp, seed, previous, status
Note: Except for version, the hash is on the byte representations and
not the string representations of the data values.

=item C<< current >>

The SHA-512 hash of the signature as a 64 byte hex string.

=item C<< status >>

Returns the status of the beacon and value chain:
0 - Chain intact, values all good
1 - Start of a new chain of values, previous hash value will be all zeroes.
2 - Time between values is greater than the frequency, but the chain is still intact

=back

=for Pod::Coverage BUILD

=head1 NAME

NIST::Beacon::Record - An object for holding records emitted by the NIST randomness beacon.

=head1 SEE ALSO

L<NIST::Beacon>

=head1 AUTHOR

William Woodruff <william@tuffbizz.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by William Woodruff.

This is free software, licensed under:

  The MIT (X11) License

=cut
