package Tartarus::Message;
# ABSTRACT: Base message format role for encoding/decoding

=head1 SYNOPSIS

    package My::Message;
    use Moo;
    with 'Tartarus::Message';

    sub encode; # Encode the message into bytes
    sub decode; # Decode the message from the given bytes

=head1 DESCRIPTION

C<Tartarus::Message> is the base role for all Tartarus message
serializers.  Serialized messages are sent out over L<Tartarus
transports|Tartarus::Transport>.

Messages define the structure of the data. Different data sources may
produce different messages. Data sources that use the same message can
be easily exchanged, replaced, and worked with in the same way.

=cut

use Tartarus::Base 'Role';

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

=method new

Create a new message.

=cut

requires 'new';

=method encode

Encode the current message to send it over the L<transport|Tartarus::Transport>.

=cut

requires 'encode';

=method decode

Decode the given message from the L<transport|Tartarus::Transport>.

=cut

requires 'decode';

1;
