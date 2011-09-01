package JLogger::Web::Action::Message::Latest;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub process {
    my $self = shift;

    my %selection = ();
    if (my $sender = $self->params->{sender}) {
        $selection{'sender.jid'} = $sender;
    }

    $self->render_json(
        [   map { $_->to_hash } $self->message->find(
                order_by => 'timestamp asc',
                limit    => 10,
                columns  => [
                    qw/id timestamp thread body recipient_resource sender_resource/
                ],
                with  => [qw/sender recipient/],
                where => [%selection]
            )
        ]
    );
}

1;
