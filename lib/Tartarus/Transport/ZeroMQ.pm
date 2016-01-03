package Tartarus::Transport::ZeroMQ;
# ABSTRACT: Send/receive Tartarus messages over ZeroMQ

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

use Tartarus::Base 'Class';
with 'Tartarus::Transport';
use ZMQ::FFI;
use ZMQ::FFI::Constants qw( ZMQ_ROUTER );

=attr endpoint

The endpoint to listen on for connections. Will bind with a C<ROUTER> socket.

=cut

has endpoint => (
    is => 'ro',
    isa => Str,
    required => 1,
);

has _ctx => (
    is => 'ro',
    lazy => 1,
    default => sub {
        return ZMQ::FFI->new;
    },
);

has _socket => (
    is => 'ro',
    lazy => 1,
    default => sub {
        my ( $self ) = @_;
        my $socket = $self->_ctx->socket( ZMQ_ROUTER );
        $socket->bind( $self->endpoint );
        return $socket;
    },
);

sub BUILD {
    $_[0]->_socket;
}

=method fh

The filehandle to watch for readability.

=cut

sub fh {
    my ( $self ) = @_;
    return $self->_socket->get_fd;
}

=method can_read

Returns true if the socket is readable

=cut

sub can_read {
    my ( $self ) = @_;
    return $self->_socket->has_pollin;
}

=method recv

Receive a message

=cut

sub recv {
    my ( $self ) = @_;
    return unless $self->_socket->has_pollin;
    return $self->_socket->recv_multipart;
}

=method send

Send a message

=cut

sub send {
    my ( $self, $to, $msg ) = @_;
    return $self->_socket->send_multipart( [ $to, $msg ] );
}

1;

