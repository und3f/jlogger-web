package JLogger::Web::Action;

use strict;
use warnings;

use JSON;

use JLogger::Web::Model::Message;
use JLogger::Web::Model::Identificator;

sub new {
    my $class = shift;
    bless {@_}, $class;
}

sub env {$_[0]->{env}}

sub params {$_[0]->{params}}

sub config {$_[0]->{config}}

sub render_json {
    my ($self, $data) = @_;

    [200, ['Content-Type', 'application/json'], [encode_json $data]];
}

sub message {
    JLogger::Web::Model::Message->new;
}

sub identificator {
    JLogger::Web::Model::Identificator->new;
}


1;
