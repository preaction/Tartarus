package Tartarus::Message::Document;

# ABSTRACT: Message allowing arbitrary fields for each entry

=head1 SYNOPSIS

=head1 DESCRIPTION

This message is meant to contain multiple items that may each have different fields,
such as those stored by MongoDB, ElasticSearch, and other document stores.

=head1 SEE ALSO

=over 4

=item L<Tartarus::Message>

=back

=cut

use Tartarus::Base 'Class';
extends 'Tartarus::Message';

=attr body

An arrayref of hashrefs of data. The primary payload of the message.

=cut

has body => (
    is => 'ro',
    isa => ArrayRef[HashRef],
    required => 1,
);

1;
