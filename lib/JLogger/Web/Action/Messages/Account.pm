package JLogger::Web::Action::Messages::Account;

use strict;
use warnings;

use base 'JLogger::Web::Action::Messages';

sub selection {
    my $self = shift;

    my $account = $self->params->{account};

    [   -or => [
            'sender.jid'    => $account,
            'recipient.jid' => $account,
        ]
    ];
}

sub get_messages {
    my $self = shift;

    my @messages = $self->SUPER::get_messages();

    foreach my $message (@messages) {
        $message->{outgoing} =
          !!($message->{sender}{jid} eq $self->params->{account});
    }

    @messages;
}

1;
