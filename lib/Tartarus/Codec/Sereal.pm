package Tartarus::Codec::Sereal;
# ABSTRACT: Use Sereal to encode/decode Tartarus messages

=head1 SYNOPSIS

    # tartarus.yml
    codec:
        $class: Tartarus::Codec::Sereal

=head1 DESCRIPTION

This L<Tartarus::Codec> encodes/decodes with L<Sereal>, a message format
produced by L<Booking.com|http://blog.booking.com> and optimized for
speed in Perl.

=cut

use Tartarus::Base 'Class';
use Sereal qw( encode_sereal decode_sereal );

=method encode

    my $bytes = $codec->encode( $msg );

Encode the message into bytes.

=cut

sub encode {
    my ( $self, $msg ) = @_;
    # Break the bless in case recipients have other classes
    return encode_sereal( { %$msg } );
}

=method decode

    my $msg = $codec->decode( $bytes );

Create a message from the given bytes.

=cut

sub decode {
    my ( $self, $bytes ) = @_;
    my $msg = decode_sereal( $bytes );
    return $msg->{type}->new( %$msg );
}

1;
