package Tartarus::Base;
# ABSTRACT: Base includes for Tartarus modules

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

use strict;
use warnings;
use base 'Import::Base';

our @IMPORT_MODULES = (
    qw( strict warnings ),
    feature => [qw( :5.20 )],
);

my @class_common = (
    'Types::Standard' => [qw( :all )],
);

our %IMPORT_BUNDLES = (
    Test => [
        qw( Test::More Test::Deep ),
    ],

    Class => [
        qw( Moo ),
        @class_common,
    ],

    Role => [
        qw( Moo::Role ),
        @class_common,
    ],
);

1;
