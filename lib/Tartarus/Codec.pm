package Tartarus::Codec;
# ABSTRACT: Base role for encoding/decoding

=head1 SYNOPSIS

    package My::Codec;
    use Moo;
    with 'Tartarus::Codec';

    sub encode; # Encode the given Tartarus::Message into bytes
    sub decode; # Decode a Tartarus::Message from the given bytes

=head1 DESCRIPTION

C<Tartarus::Codec> is the base role for all Tartarus message
serializers.  Serialized messages are sent out over L<Tartarus
transports|Tartarus::Transport>.

Codecs are how the messages are serialized/deserialized and must be
coordinated with the client and the server. Each transport has a codec.

=cut

use Tartarus::Base 'Role';

=method new

Create a new codec.

=cut

requires 'new';

=method encode

Encode the given message to send it over the L<transport|Tartarus::Transport>.

=cut

requires 'encode';

=method decode

Decode the given message from the L<transport|Tartarus::Transport>.

=cut

requires 'decode';

1;
