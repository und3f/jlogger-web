package JLogger::Web::Action;

use strict;
use warnings;

use File::Spec;
use JSON;
use Plack::Request;
use Text::Caml;
require Carp;

use JLogger::Web::Model::Message;
use JLogger::Web::Model::Identificator;

use JLogger::Web::Renderer::JSON;
use JLogger::Web::Renderer::Mustache;

sub new {
    my $class = shift;

    bless {@_}, $class;
}

sub env { $_[0]->{env} }

sub req { $_[0]->{req} ||= Plack::Request->new($_[0]->{env}) }

sub params { $_[0]->{params} }

sub config { $_[0]->{config} }

sub renderer { $_[0]->{renderer} }

sub render {
    my ($self, $data) = @_;

    my $format = $self->params->{format};
    unless ($format) {
        if (my $accept = $self->req->header('Accept')) {
            ($accept) = split /,/, $accept, 2;
            ($accept) = split /;/, $accept;

            $format = 'json' if ($accept eq 'application/json');
        }
        $format ||= 'html';
    }
    my $template =
      ($self->params->{template} || $self->params->{action}) . '.mt';

    my ($ct, $body) = @{
        $self->renderer->render(
            $data,
            {   format   => $format,
                params   => $self->params,
                template => $template,
                uri      => \&_helper_uri_escape,
            }
        )
      };

    [200, ['Content-Type', $ct], [$body]];
}

sub render_not_found {
    my $self = shift;

    [404, ['Content-Type', 'text/plain'], ['Not found']];
}

sub message {
    JLogger::Web::Model::Message->new;
}

sub identificator {
    JLogger::Web::Model::Identificator->new;
}

sub _helper_uri_escape {
    my ($renderer, $url) = @_;
    return URI::Escape::uri_escape($url, '^A-Za-z0-9\-\._~/');
};

1;
