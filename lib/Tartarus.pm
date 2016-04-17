package Tartarus;
# ABSTRACT: The scalable data warehouse of the gods

=head1 SYNOPSIS

    # tartarus.yml
    mounts:
        user:
            $class: Tartarus::DataSource::Postgres
            host: localhost
        stats:
            $class: Tartarus::DataSource::RRDTool
            root: /var/db/rrdtool
        orders:
            $class: Tartarus::DataSource::MySQL
            host: db.example.com
    transport:
        $class: Tartarus::Transport::ZeroMQ
        endpoint: tcp://*:7000
    message:
        $class: Tartarus::Message::Sereal

    # Start the server
    tartarus [-f <config_file>]

=head1 DESCRIPTION

Tartarus is a server that provides a unified API on to multiple data
sources, mounted in a tree. Users may make requests of the data, reading
and writing, or they can subscribe to messages as they pass through the
API, allowing for notification of updates.

Tartarus is built to help data warehouses be scalable and flexible. The
unified API makes simple data maintenance tasks trivial, allows for easy
migration of data between backend data platforms, and enables
scalability features like sharding and caching that the backend data
platform may not support.

=head2 Data Source

Tartarus collects multiple L<data sources|Tartarus::DataSource>,
arranged in a tree. Each data source can expose its data as a tree as
well, mapping the data in a logical, navigable structure.

Data sources can be relational databases like Postgres and MySQL,
document stores like MongoDB and ElasticSearch, and time series
databases like RRDTool and Graphite.

Tartarus can use other Tartarus servers as data sources, allowing for
sharding, failover, and other scalability patterns.

Custom data sources can take any form, allowing easy access to things
like SNMP data. Custom data sources can also filter and transform
existing data sources, allowing for on-the-fly transforms and analysis.

=head2 Transport

Tartarus allows incoming connections via a transport, like ZeroMQ,
nanomsg, HTTP, WebSockets, or plain TCP. Multiple transports can be
configured, allowing multiple types of clients.

=head2 Message

Tartarus messages can be serialized by one of many types of message
format, including Sereal, Protocol Buffers, MessagePack, Cap'n Proto,
JSON, BSON, and more.

Tartarus messages create a common data structure so that different data
sources can be used by the same program.

=head1 SEE ALSO

=over

=item *

L<Tartarus::DataSource>

=item *

L<Tartarus::Transport>

=item *

L<Tartarus::Message>

=back

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

