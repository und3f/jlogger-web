package JLogger::Web::Action::Account;

use strict;
use warnings;

use base 'JLogger::Web::Action';

use List::MoreUtils 'uniq';

sub process {
    my $self = shift;

    my $account_id = $self->identificator->find(
        {jid => $self->params->{account}}
    )->id;

    return $self->render_not_found unless $account_id;
    
    my $incoming =
      $self->message->search({sender => $account_id},
        {select => 'recipient'});

    my $outgoing =
      $self->message->search({recipient => $account_id},
        {select => 'sender'});

    my $rs = $self->identificator->search(
        [   'me.id' => {-in => $incoming->as_query},
            'me.id' => {-in => $outgoing->as_query}
        ],
        {   join     => 'involved_messages',
            order_by => {-desc => 'timestamp'},
            group_by => 'me.id',
            select   => [
                'me.jid',
                {max => 'involved_messages.timestamp', -as => 'timestamp'}
            ]
        }
    );

    my @connected_accounts = map {$_->jid} $rs->all;
    $self->render({chats => [uniq @connected_accounts],});
}

1;
