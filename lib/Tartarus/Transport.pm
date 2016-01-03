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

    my ( $from, $bytes ) = $xport->recv;

Receive an incoming message and the identity of the sender. Returns
a set of bytes suitable to be L<decoded by
a codec|Tartarus::Codec/decode>.

=cut

requires 'recv';

=method send

    $xport->send( $to => $bytes );

Send an outgoing message to the given client. Requires a set of bytes
L<encoded by a codec|Tartarus::Codec/encode>.

=cut

requires 'send';

=method fh

Get the filehandle to poll for incoming messages. When messages are ready,
call L</recv> to receive them.

=cut

requires 'fh';

=method can_read

Returns true if we can read from the L<filehandle|/fh>. Reading is done
with L<the recv() method|/recv>.

=cut

requires 'can_read';

1;
