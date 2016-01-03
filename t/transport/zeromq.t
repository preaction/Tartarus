
use Tartarus::Base 'Test';
use Tartarus::Transport::ZeroMQ;
use ZMQ::FFI;
use ZMQ::FFI::Constants qw( ZMQ_DEALER ZMQ_DONTWAIT );
use AnyEvent;
use File::Temp qw( tempfile );
use Data::Dumper;

my ( $fh, $fname ) = tempfile;
my $endpoint = 'ipc://' . $fname;

my $xport = Tartarus::Transport::ZeroMQ->new(
    endpoint => $endpoint,
);
diag "ZeroMQ version: " . join ".", $xport->_ctx->version;

subtest 'send' => sub {

    my $expect_msg = "Bytes";

    # CLIENT ID MUST BE UNIQUE!
    my $client_id = "foo-send";
    my $client = ZMQ::FFI->new;
    my $client_sock = $client->socket( ZMQ_DEALER );
    $client_sock->set_identity( $client_id );
    $client_sock->connect( $endpoint );

    my $cv = AE::cv;
    my $recv = 0;
    my $w = AE::io $client_sock->get_fd, 0, sub {
        while ( $client_sock->has_pollin ) {
            my $got_msg = $client_sock->recv;
            is $got_msg, $expect_msg;
            $cv->send if ++$recv >= 3;;
        }
    };

    my $t = AE::timer 3, 0, sub {
        fail "Timeout reached";
        $cv->send;
    };

    $xport->send( $client_id => $expect_msg );
    $xport->send( $client_id => $expect_msg );
    $xport->send( $client_id => $expect_msg );

    $cv->recv;
    undef $t;
};

subtest 'recv' => sub {

    # CLIENT ID MUST BE UNIQUE!
    my $client_id = "foo-recv";
    my $expect_msg = "Bytes";

    my $cv = AE::cv;
    my $recv = 0;

    my $w = AE::io $xport->fh, 0, sub {
        while ( $xport->can_read ) {
            my @got_msg = $xport->recv;
            cmp_deeply \@got_msg, [ $client_id, $expect_msg ];
            $cv->send if ++$recv >= 3;
        }
    };

    my $t = AE::timer 3, 0, sub {
        fail "Timeout reached";
        $cv->send;
    };

    my $client = ZMQ::FFI->new;
    my $client_sock = $client->socket( ZMQ_DEALER );
    $client_sock->set_identity( $client_id );
    $client_sock->connect( $endpoint );
    $client_sock->send( $expect_msg );
    $client_sock->send( $expect_msg );
    $client_sock->send( $expect_msg );

    $cv->recv;
    undef $t;
};

done_testing;
