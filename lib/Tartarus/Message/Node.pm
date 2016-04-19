package Tartarus::Message::Node;

# ABSTRACT: Get info about a node in the tree, including children

=head1 SYNOPSIS

=head1 DESCRIPTION

This message shows information about a single node, including the type
of message it will return from a C<get> request, and the names of any
children it may have. This is the standard response from a C<list>
request.

=head1 SEE ALSO

=over 4

=item L<Tartarus::Message>

=back

=cut

use Tartarus::Base 'Class';
extends 'Tartarus::Message';

=attr message

Information about the message that this node would send as a response
to a C<get> request. This will include the type, and for certain messages,
the columns available, the date range, and more.

=cut

has message => (
    is => 'ro',
    isa => InstanceOf['Tartarus::Message'],
    required => 1,
);

=attr children

The children of this node. An arrayref of strings with the name of the
child node.

=cut

has children => (
    is => 'ro',
    isa => Maybe[ArrayRef[Str]],
);

=method body

Get the body of this message.

=cut

sub body {
    my ( $self ) = @_;
    return [ $self->message, $self->children ];
}

1;
