package JLogger::Web::Action::Messages::Chat;

use strict;
use warnings;

use base 'JLogger::Web::Action::Messages';

sub selection {
    my $self = shift;
    my ($jid1, $jid2) = @{$self->params}{qw/account interlocutor/};

    [   -or => [
            -and => [
                'sender.jid'    => $jid1,
                'recipient.jid' => $jid2,
            ],
            -and => [
                'sender.jid'    => $jid2,
                'recipient.jid' => $jid1,
            ]
        ]
    ];

}

1;
