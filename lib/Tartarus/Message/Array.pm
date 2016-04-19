package Tartarus::Message::Array;

# ABSTRACT: Message for compact transmission of rows/columns of data

=head1 SYNOPSIS

=head1 DESCRIPTION

This message is meant to contain items that each share the same fields, such
as those stored in relational database tables and time series databases.

=head1 SEE ALSO

=over 4

=item L<Tartarus::Message>

=back

=cut

use Tartarus::Base 'Class';
extends 'Tartarus::Message';

=attr columns

An arrayref of column names. Each column index corresponds to a column
in the L<body|/body> items.

=cut

has columns => (
    is => 'ro',
    isa => ArrayRef[Str],
    required => 0,
);

=attr body

An arrayref of arrayrefs of data. The primary payload of the message.

=cut

has body => (
    is => 'ro',
    isa => ArrayRef[HashRef],
    required => 1,
);

1;
