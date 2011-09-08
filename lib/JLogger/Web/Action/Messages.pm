package JLogger::Web::Action::Messages;

use strict;
use warnings;

use base 'JLogger::Web::Action';

sub selection { [] }

sub is_outgoing_message {
    my ($self, $message) = @_;

    my $domain = $self->config->{domain};
    !!($message->{sender}{jid} =~ /\@$domain$/i);
}

sub format_load_url {
    '/messages';
}

sub get_messages {
    my $self = shift;

    my $page = $self->params->{page} = $self->req->param('page') || 1;

    my $per_page = $self->config->{messages_per_page};

    my @messages = map { $_->to_hash } $self->message->find(
        with     => [qw/sender recipient/],
        where    => $self->selection,
        order_by => 'timestamp desc',
        limit    => $per_page,
        offset   => ($page - 1) * $per_page,
    );

    foreach my $message (@messages) {
        utf8::decode($message->{body});
        $message->{outgoing} = $self->is_outgoing_message($message);
    }

    @messages;
}

sub process {
    my $self = shift;

    $self->params->{template} = 'just_messages'
      if $self->req->param('no_layout');

    $self->render(
        {   messages => [$self->get_messages],
            load_url => $self->format_load_url
        }
    );
}

1;
