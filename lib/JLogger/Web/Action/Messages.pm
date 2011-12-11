package JLogger::Web::Action::Messages;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub selection { [] }

sub is_outgoing_message {
    my ($self, $message) = @_;

    my $domain = $self->config->{domain};
    !!($message->{sender} =~ /\@$domain$/i);
}

sub format_load_url {
    '/messages';
}

sub get_messages {
    my $self = shift;

    my $page = $self->params->{page} = $self->req->param('page') || 1;

    my $per_page = $self->config->{messages_per_page};

    my $rs = $self->message->search(
        $self->selection,
        {   join     => [qw/sender recipient/],
            order_by => {-desc => 'timestamp'},
            rows     => $per_page,
            page     => $page,
        }
    );

    my @messages;
    while (my $r = $rs->next) {
        my $message = {
            sender             => $r->sender->jid,
            sender_resource    => $r->sender_resource,
            recipient          => $r->recipient->jid,
            recipient_resource => $r->recipient_resource,
            timestamp          => $r->timestamp->iso8601,
            id                 => $r->id,
            body               => $r->body,
        };
        utf8::decode($message->{body});
        $message->{outgoing} = $self->is_outgoing_message($message);

        push @messages, $message;
    }

    @messages;
}

sub process {
    my $self = shift;

    $self->render(
        {   messages => [$self->get_messages],
            load_url => $self->format_load_url,
            no_layout => $self->req->param('no_layout') || 0,
        }
    );
}

1;
