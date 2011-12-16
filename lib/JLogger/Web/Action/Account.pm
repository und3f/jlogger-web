package JLogger::Web::Action::Account;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub process {
    my $self = shift;

    my $account_id =
      $self->identificator->find({jid => $self->params->{account}})->id;

    return $self->render_not_found unless $account_id;

    my $rs = $self->message->search(
        [   sender    => $account_id,
            recipient => $account_id
        ],
        {   join     => 'involved',
            order_by => {-desc => 'timestamp'},
            group_by => 'involved',
            select   => [
                \"CASE WHEN sender = $account_id THEN recipient ELSE sender END AS involved",
                {max => 'me.timestamp'},
                'involved.jid',
            ],
            as => [qw/involved timestamp jid/]
        }
    );

    my @connected_accounts = map { $_->get_column('jid') } $rs->all;
    $self->render({chats => \@connected_accounts});
}

1;
