package JLogger::Web::Action::Message::Senders;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub process {
    my $self = shift;

    $self->render_json(
        {accounts => $self->message->find(with => ['sended_messages'])}
    );
}

1;
