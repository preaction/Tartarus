package Tartarus::Message;
# ABSTRACT: Base message format role for encoding/decoding

=head1 SYNOPSIS

=head1 DESCRIPTION

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
