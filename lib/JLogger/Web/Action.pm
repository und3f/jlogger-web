package JLogger::Web::Action;

use strict;
use warnings;
use utf8;

use File::Spec;
use JSON;
use Text::Caml;
require Carp;

use JLogger::Web::Model::Message;
use JLogger::Web::Model::Identificator;

sub new {
    my $class = shift;
    bless {@_}, $class;
}

sub env { $_[0]->{env} }

sub params { $_[0]->{params} }

sub config { $_[0]->{config} }

sub render {
    my $self = shift;

    my $format = $self->params->{format} || 'html';
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

sub render_html {
    my ($self, $data) = @_;

    my $view = Text::Caml->new;
    $view->set_templates_path($self->config->{templates_home});

    my $html = $view->render_file(
        ($self->params->{template} || $self->params->{action}) . '.mt',
        {%$data, config => $self->config, params => $self->params}
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
