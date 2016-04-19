
use Tartarus::Base 'Test';
use Tartarus::Codec::Sereal;
use Tartarus::Message;
use Sereal qw( decode_sereal encode_sereal );

subtest 'encode' => sub {
    my %expect_msg = (
        path => '/foo',
        method => 'read',
        query => {
            id => 3263857,
        },
    );

    my $codec = Tartarus::Codec::Sereal->new;
    my $bytes = $codec->encode( Tartarus::Message->new( %expect_msg ) );
    my $got_msg = decode_sereal( $bytes );

    cmp_deeply $got_msg, {
        %expect_msg,
        id => ignore(),
        type => 'Tartarus::Message',
    } or diag explain $got_msg;
};

subtest 'decode' => sub {
    my %expect_msg = (
        id => Data::UUID->new->create,
        type => 'Tartarus::Message',
        path => '/foo',
        method => 'read',
        query => {
            id => 3263857,
        },
    );

    my $bytes = encode_sereal( \%expect_msg );
    my $codec = Tartarus::Codec::Sereal->new;
    my $got_msg = $codec->decode( $bytes );
    cmp_deeply $got_msg, Tartarus::Message->new( %expect_msg );
};

done_testing;

