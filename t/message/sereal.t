
use Tartarus::Base 'Test';
use Tartarus::Message::Sereal;
use Sereal qw( decode_sereal encode_sereal );

subtest 'encode' => sub {
    my %expect_msg = (
        path => '/foo',
        method => 'read',
        query => {
            id => 3263857,
        },
    );

    my $msg = Tartarus::Message::Sereal->new( %expect_msg );
    my $bytes = $msg->encode;
    my $got_msg = decode_sereal( $bytes );

    cmp_deeply $got_msg, \%expect_msg or diag explain $got_msg;
};

subtest 'decode' => sub {
    my %expect_msg = (
        path => '/foo',
        method => 'read',
        query => {
            id => 3263857,
        },
    );

    my $bytes = encode_sereal( \%expect_msg );
    my $got_msg = Tartarus::Message::Sereal->decode( $bytes );
    is $got_msg->path, '/foo';
    is $got_msg->method, 'read';
    cmp_deeply $got_msg->query, { id => 3263857 };
};

done_testing;

