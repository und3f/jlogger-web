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

1;
