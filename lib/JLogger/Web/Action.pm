package JLogger::Web::Action;

use strict;
use warnings;

use File::Spec;
use JSON;
use Plack::Request;
use Text::Caml;
use URI::Escape ();
require Carp;

use JLogger::Web::Model::Message;
use JLogger::Web::Model::Identificator;

sub new {
    my $class = shift;
    bless {@_}, $class;
}

sub env { $_[0]->{env} }

sub req { $_[0]->{req} ||= Plack::Request->new($_[0]->{env}) }

sub params { $_[0]->{params} }

sub config { $_[0]->{config} }

sub render {
    my $self = shift;

    my $format = $self->params->{format};
    unless ($format) {
        if (my $accept = $self->req->header('Accept')) {
            ($accept) = split /,/, $accept, 2;
            ($accept) = split /;/, $accept;

            $format = 'json' if ($accept eq 'application/json');
        }
        $format ||= 'html';
    }

    if ($format eq 'html') {
        $self->render_html(@_);
    }
    elsif ($format eq 'json') {
        $self->render_json(@_);
    }
    else {
        Carp::croak(qq{Unknown format "$format"});
    }
}

sub render_json {
    my ($self, $data) = @_;

    [200, ['Content-Type', 'application/json'], [encode_json $data]];
}

sub uri_escape {
    my ($self, $url) = @_;

    return URI::Escape::uri_escape($url, '^A-Za-z0-9\-\._~/');
}

sub render_html {
    my ($self, $data) = @_;

    my $view = Text::Caml->new;
    $view->set_templates_path($self->config->{templates_home});

    my $html = $view->render_file(
        ($self->params->{template} || $self->params->{action}) . '.mt',
        {   %$data,
            config => $self->config,
            params => $self->params,
            uri    => sub {
                my ($renderer, $text) = @_;
                $self->uri_escape($text);
            },
        }
    );
    utf8::encode($html);
    [200, ['Content-Type', 'text/html'], [$html]];
}

sub message {
    JLogger::Web::Model::Message->new;
}

sub identificator {
    JLogger::Web::Model::Identificator->new;
}

1;
