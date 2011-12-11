package JLogger::Web::Action::Messages::Account;

use strict;
use warnings;

use base 'JLogger::Web::Action::Messages';

sub selection {
    my $self = shift;

    my $account = $self->params->{account};

    [{'sender.jid' => $account}, {'recipient.jid' => $account}];
}

sub is_outgoing_message {
    my ($self, $message) = @_;

    !!($message->{sender} eq $self->params->{account});
}

sub format_load_url {
    my $self = shift;

    '/' . $self->params->{account} . '/messages';
}

1;
