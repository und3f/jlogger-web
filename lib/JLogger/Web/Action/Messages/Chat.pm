package JLogger::Web::Action::Messages::Chat;

use strict;
use warnings;

use base 'JLogger::Web::Action::Messages::Account';

sub selection {
    my $self = shift;
    my ($jid1, $jid2) = @{$self->params}{qw/account interlocutor/};

    [   {   'sender.jid'    => $jid1,
            'recipient.jid' => $jid2,
        },
        {   'sender.jid'    => $jid2,
            'recipient.jid' => $jid1,
        },
    ];
}

sub format_load_url {
    my $self = shift;

    join('/', '', @{$self->params}{qw/account interlocutor/});
}

1;
