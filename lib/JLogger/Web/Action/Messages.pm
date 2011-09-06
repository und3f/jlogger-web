package JLogger::Web::Action::Messages;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub selection { [] }

sub get_messages {
    my $self = shift;

    map { $_->to_hash } $self->message->find(
        with     => [qw/sender recipient/],
        where    => $self->selection,
        order_by => 'timestamp desc',
        limit    => $self->config->{messages_per_page},
    );
}

sub process {
    my $self = shift;

    $self->render({messages => [$self->get_messages]});
}

1;
