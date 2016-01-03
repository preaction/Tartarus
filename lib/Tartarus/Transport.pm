package Tartarus::Transport;
# ABSTRACT: Base role for transport layers

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

use Tartarus::Base 'Role';

=method new

Create and configure the transport, setting up the sockets or otherwise.

=cut

requires 'new';

=method recv

Receive an incoming message. Returns a set of bytes suitable to be
L<decoded by a codec|Tartarus::Codec/decode>.

=cut

requires 'recv';

=method send

Send an outgoing message. Requires a set of bytes L<encoded by
a codec|Tartarus::Codec/encode>.

=cut

requires 'send';

=method fh

Get the filehandle to poll for incoming messages. When messages are ready,
call L</recv> to receive them.

=cut

requires 'fh';

1;
