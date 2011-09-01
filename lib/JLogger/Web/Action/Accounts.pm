package JLogger::Web::Action::Accounts;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub process {
    my $self = shift;

    $self->render_json([
                map { $_->column('jid') } $self->identificator->find(
                    where => [jid => {like => '%@' . $self->config->{domain}}]
                )
            ]
    );
}

1;
