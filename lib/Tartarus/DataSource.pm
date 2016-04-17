package Tartarus::Adapter;
# ABSTRACT: Base role for connecting to data sources

=head1 SYNOPSIS

    package My::DataSource;
    use Moo;
    with 'Tartarus::DataSource';

    sub read;   # read a path with optional query params
    sub write;  # write to a path
    sub list;   # list children of a path

=head1 DESCRIPTION

A C<Tartarus::DataSource> is an adapter to connect a source of data into
the Tartarus tree. Simple data sources may be relational databases,
document stores, or time series databases. Other data sources may be
filters or transforms on simple data sources, allowing on-the-fly data
analytics.

This is the base role that defines the interface that all data sources
must implement.

=cut

use Tartarus::Base 'Role';

=method read

    my @data = $ds->read( $path, $query );

Read data from the data source at the given path, optionally restricted to the given
query parameters.

=cut

requires 'read';

=method list

    my @names = $ds->list( $path );

List the available children at the given path.

=cut

requires 'list';

=method write

    $ds->write( $path, @documents );

Write data to the given path.

=cut

requires 'write';

1;
