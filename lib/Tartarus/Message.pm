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
use Data::UUID;
use Scalar::Util qw( blessed );

=attr id

The ID of the message. Generated automatically if necessary.

=cut

has id => (
    is => 'ro',
    isa => Str,
    default => sub { Data::UUID->new->create },
);

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

=attr type

The type of message. Auto-generated from the message object's class name.

This is used to inflate the correct object on the other end. Libraries
should not force users to set this.

=cut

has type => (
    is => 'ro',
    isa => Str,
    default => sub { return blessed $_[0] },
);

=method head

    my %head = $msg->head;

Get the message header. The header includes the C<id>, C<path>, C<method>,
and C<query> attributes.

=cut

sub head {
    my ( $self ) = @_;
    return (
        map {; $_ => $self->$_ } qw( id path method query )
    );
}

=method body

    my %body = $msg->body;

Get the message body. The message body depends on the type of message.
This class defines no message body.

=cut

sub body {
    return;
}

1;

