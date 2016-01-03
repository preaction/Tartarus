package Tartarus::Adapter;
# ABSTRACT: Base role for connecting to data sources

=head1 SYNOPSIS

=head1 DESCRIPTION

Tartarus exposes a data source as a navigable tree.

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
