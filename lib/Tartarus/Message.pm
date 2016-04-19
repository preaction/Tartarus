package Tartarus::Message;

# ABSTRACT: Base class for Tartarus messages

=head1 DESCRIPTION

Messages define the structure of the data. Different data sources may
produce different messages. Data sources that use the same message can
be easily exchanged, replaced, and worked with in the same way.

Tartarus comes with a number of common message types for
interoperability. Other messages may be created for your own purposes.

Every message is split into a header (the envelope) and a body (the
payload). The header describes the type of message and where it should
be routed. This header will be read by every part of the Tartarus
network.  The body is meant only for the final destination.  All
messages will have a header, but not all messages will have a body.

=head1 SEE ALSO

XXX The individual message types will be listed here.

=cut

use Tartarus::Base 'Class';

=attr path

The path this message is regarding. Required.

=cut

has path => (
    is => 'ro',
    isa => Str,
    required => 1,
);

=attr method

The method this message is performing. Required.

=cut

has method => (
    is => 'ro',
    isa => Str,
    required => 1,
);

=attr query

A hash of query parameters for this message. Optional.

=cut

has query => (
    is => 'ro',
    isa => HashRef,
    default => sub { {} },
);

1;
