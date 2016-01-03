package Tartarus;
# ABSTRACT: The scalable data warehouse of the gods

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

use Tartarus::Base 'Class';

=attr message

    message:
        $class: Tartarus::Message::Sereal

The message type to use

=cut

has message => (
    is => 'ro',
    isa => ConsumerOf['Tartarus::Message'],
);

=attr transport

    transport:
        $class: Tartarus::Transport::ZeroMQ
        $args:
            endpoint: tcp://127.0.0.1:7000

The transport layer to use

=cut

has transport => (
    is => 'ro',
    isa => ConsumerOf['Tartarus::Transport'],
);

=attr mounts

    mounts:
        /customers:
            $class: Tartarus::DataSource::Postgres
            $args:
                host: localhost
                port: 4660
        /usage:
            $class: Tartarus::DataSource::RRDTool
            $args:
                root_dir: /var/db/rrd

Mount a L<data source|Tartarus::DataSource> at a path.

=cut

has mounts => (
    is => 'ro',
    isa => HashRef[ConsumerOf['Tartarus::DataSource']],
);

=method run

    $t->run();

Start the daemon.

=cut

sub run {

}

1;
__END__

