package JLogger::Web::Action::Index;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub process {
    my $self = shift;

    my $accounts = [
        map { $_->column('jid') } $self->identificator->find(
            where => [jid => {like => '%@' . $self->config->{domain}}]
        )
    ];

    $self->render({accounts => $accounts});
}

1;
