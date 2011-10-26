package JLogger::Web::Renderer;

use strict;
use warnings;

require Carp;
use Class::Load 'load_class';

my %format2renderer = (
    'html' => 'Mustache',
    'json' => 'JSON',
);

sub new {
    my $class = shift;
    bless {@_, _renderers => {}}, $class;
}

sub render {
    my ($self, $data, $params) = @_;

    my $format = delete $params->{format};
    my $name = $format2renderer{$format};

    Carp::croak(qq{Unknown format "$format"}) unless $name;

    unless ($self->{_renderers}->{$name}) {
        my $class = "JLogger::Web::Renderer::$name";

        load_class $class;

        $self->{_renderers}->{$name} =
          $class->new(home => $self->{home});
    }

    $self->{_renderers}->{$name}->render($data, $params);
}

1;
