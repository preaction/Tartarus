package Tartarus::Message::Sereal;
# ABSTRACT: Use Sereal to encode/decode Tartarus messages

=head1 SYNOPSIS

    # tartarus.yml
    message:
        $class: Tartarus::Message::Sereal

=head1 DESCRIPTION

This message is encoded/decoded with Sereal, a message format produced
by L<Booking.com|http://blog.booking.com> and optimized for speed in
Perl.

=cut

use Tartarus::Base 'Class';
use Sereal qw( encode_sereal decode_sereal );
with 'Tartarus::Message';

=method encode

    my $bytes = $msg->encode;

Encode the message into bytes.

=cut

sub encode {
    my ( $self ) = @_;
    # Break the bless in case recipients have other classes
    return encode_sereal( { %$self } );
}

=method decode

    my $msg = Tartarus::Message::Sereal->decode( $bytes );

Create a message from the given bytes.

=cut

sub decode {
    my ( $class, $bytes ) = @_;
    return $class->new( decode_sereal( $bytes ) );
}

1;
