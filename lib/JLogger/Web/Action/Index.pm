package JLogger::Web::Action::Index;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub process {
    my $self = shift;

    my $accounts = [
        map { $_->jid } $self->identificator->search(
            {jid => {-like => '%@' . $self->config->{domain}}}
        )
    ];

    $self->render({accounts => $accounts});
}

1;
