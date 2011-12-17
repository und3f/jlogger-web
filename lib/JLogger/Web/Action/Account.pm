package JLogger::Web::Action::Account;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub process {
    my $self = shift;

    my $account =
      $self->identificator->find({jid => $self->params->{account}});

    return $self->render_not_found unless $account;

    my $account_id = $account->id;

    my $rs = $self->message->search(
        [   sender    => $account_id,
            recipient => $account_id
        ],
        {   join     => [qw/sender recipient/],
            order_by => {-desc => 'timestamp'},
            group_by => 'involved',
            select   => [
                \"CASE WHEN sender = $account_id THEN recipient.jid ELSE sender.jid END AS involved",
                {max => 'me.timestamp', -as => 'timestamp'},
            ],
            as => [qw/involved timestamp/]
        }
    );

    my @connected_accounts = map { $_->get_column('involved') } $rs->all;
    $self->render({chats => \@connected_accounts});
}

1;
