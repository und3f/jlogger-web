package JLogger::Web::Action::Account;

use strict;
use warnings;

use base 'JLogger::Web::Action';

use List::MoreUtils 'uniq';

sub process {
    my $self = shift;

    my $account = $self->identificator->find(
        columns => 'id',
        where   => [jid => $self->params->{account}]
    )->next;

    return $self->render_not_found unless $account;
    
    my $account_id = $account->id;

    # TODO: rewrite this to one query:
    # SELECT jid.jid
    # FROM messages message
    # JOIN identificators jid
    #   ON (jid.id = message.sender AND message.recipient = 1)
    #   OR (jid.id = message.recipient AND message.sender = 1);

    my @connected_accounts;
    @connected_accounts =
      map { $_->related('sender')->jid } $self->message->find(
        columns  => [],
        where    => [recipient => $account_id],
        with     => 'sender',
        group_by => 'sender',
      );

    push @connected_accounts,
      map { $_->related('recipient')->jid } $self->message->find(
        columns  => 'recipient',
        where    => [sender => $account_id],
        group_by => 'recipient',
      );

    $self->render({chats => [uniq @connected_accounts],});
}

1;
