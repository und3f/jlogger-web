package JLogger::Web;

use strict;
use warnings;

use Routes::Tiny      ();
use String::CamelCase ();
use Class::Load       ();

use JLogger::Web::Model;

sub new {
    my $class = shift;
    bless {@_}, $class;
}

sub config { $_[0]->{config} }

sub init {
    my $self = shift;

    my $db_config = $self->config->{database};

    die 'Database connection information missed'
      if !$db_config || !$db_config->{source};
    JLogger::Web::Model->conn($db_config);

    $self->build_routes;
}

sub build_routes {
    my $self = shift;

    my $routes = $self->{routes} = Routes::Tiny->new;

    $routes->add_route('/accounts', defaults => {action => 'accounts'});

    $routes->add_route('/messages/latest',
        defaults => {action => 'message/latest'});

    $routes->add_route('/messages/:sender/latest',
        defaults => {action => 'message/latest'});
}

sub dispatch_request {
    my ($self, $env) = @_;

    my $path   = $env->{PATH_INFO};
    my $method = $env->{REQUEST_METHOD};

    if (my $route = $self->{routes}->match($path, method => $method)) {
        my $action_class =
          String::CamelCase::camelize($route->{params}{action});
        $action_class =~ s{/}{::}g;
        $action_class = 'JLogger::Web::Action::' . $action_class;

        Class::Load::load_class($action_class);

        my $action = $action_class->new(
            env    => $env,
            params => $route->{params},
            config => $self->config
        );

        return $action->process;
    }

    [404, ['Content-Type', 'text/plain'], ['Not found']];
}

sub to_psgi_app {
    my $self = shift;

    sub { $self->dispatch_request(@_) };
}

1;
