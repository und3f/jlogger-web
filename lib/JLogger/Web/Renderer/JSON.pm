package JLogger::Web::Renderer::JSON;

use strict;
use warnings;

use base 'JLogger::Web::Renderer';

use JSON;

sub new {
    my $class = shift;

    my $self = $class->SUPER::new(@_);

    $self->{_json} = JSON->new;

    $self;
}

sub render {
    my ($self, $data, $params) = @_;
    
    ['application/json', $self->{_json}->encode($data)];
}

1;
