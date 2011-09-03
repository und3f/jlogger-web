package JLogger::Web::Action::Messages;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub selection { [] }

sub process {
    my $self = shift;

    $self->render(
        {   messages => [
                map { $_->to_hash } $self->message->find(
                    with     => [qw/sender recipient/],
                    where    => $self->selection,
                    order_by => 'timestamp desc',
                    limit    => $self->config->{messages_per_page},
                )
            ]
        }
    );
}

1;
