package JLogger::Web::Action::Messages;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub selection { [] }

sub is_outgoing_message {
    my ($self, $message) = @_;

    my $domain = $self->config->{domain};
    !!($message->{sender}{jid} =~ /$domain$/i);
}

sub get_messages {
    my $self = shift;

    my @messages = map { $_->to_hash } $self->message->find(
        with     => [qw/sender recipient/],
        where    => $self->selection,
        order_by => 'timestamp desc',
        limit    => $self->config->{messages_per_page},
    );

    foreach my $message (@messages) {
        $message->{outgoing} = $self->is_outgoing_message($message);
    }

    @messages;
}

sub process {
    my $self = shift;

    $self->render({messages => [$self->get_messages]});
}

1;
