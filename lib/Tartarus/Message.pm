package Tartarus::Message;
# ABSTRACT: Base message format role for encoding/decoding

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

use Tartarus::Base 'Role';

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
