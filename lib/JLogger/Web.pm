package JLogger::Web;

use strict;
use warnings;

use Class::Load       ();
use Routes::Tiny      ();
use String::CamelCase ();

use JLogger::Web::Schema;
use JLogger::Web::Renderer;
use DBIx::Connector;

my $default_config = {messages_per_page => 10};

sub new {
    my $class = shift;
    my $self = bless {@_}, $class;

    $self->{config} = {%$default_config, %{$self->{config}}};

    $self;
}

sub config { $_[0]->{config} }

sub init {
    my $self = shift;

    my $db_config = $self->config->{database};

    die 'Database connection information missed'
      if !$db_config || !$db_config->{source};
    my $db = $self->_db_connect($db_config);
    JLogger::Web::Schema->connection(sub {$db->dbh});

    $self->{_renderer} = JLogger::Web::Renderer->new(home => $self->config->{templates_home});

    $self->build_routes;
}

sub build_routes {
    my $self = shift;

    my $routes = $self->{routes} = Routes::Tiny->new;

    $routes->add_route('/', defaults => {action => 'index'});

    $routes->add_route('/messages', defaults => {action => 'messages'});

    $routes->add_route('/:account', defaults => {action => 'account'});

    $routes->add_route('/:account/messages',
        defaults => {action => 'messages/account', template => 'messages'});

    $routes->add_route('/:account/:interlocutor',
        defaults => {action => 'messages/chat', template => 'messages'});
}

sub _db_connect {
    my ($self, $db_config) = @_;

    my ($source, $username, $password, $attr) =
      @{$db_config}{qw/source username password attr/};
    $attr ||= {};

    my $conn = DBIx::Connector->new(
        $source,
        $username,
        $password,
        {   RaiseError => 1,
            ReadOnly   => 1,
            %$attr
        }
    );
    die $DBI::errorstr unless $conn;

    $conn;
}

sub dispatch_request {
    my ($self, $env) = @_;

    my $path   = $env->{PATH_INFO};
    my $method = $env->{REQUEST_METHOD};

    if (my $route = $self->{routes}->match($path, method => $method)) {
        my $action_class =
          String::CamelCase::camelize($route->{captures}{action});
        $action_class =~ s{/}{::}g;
        $action_class = 'JLogger::Web::Action::' . $action_class;

        Class::Load::load_class($action_class);

        my $action = $action_class->new(
            env      => $env,
            params   => $route->{captures},
            config   => $self->config,
            renderer => $self->{_renderer},
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
__END__

=head1 NAME

JLogger::Web - web interface for L<JLogger>

=head1 INSTALLATION

=over

=item *

Get latest JLogger
    
    git clone git://github.com/und3f/jlogger-web.git
    git submodule update --init

=item *

Install L<cpanminus>

=item *

Install ObjectDB2 (not yet on CPAN)
    
    cpanm -S https://github.com/vti/object-db2/tarball/master

=item *

Install JLogger::Web dependecies

    cpanm -S --installdeps .

=item *

Create config file and edit it

    cp jlogger-web.yaml{.example,}

=item *

Start JLogger::Web

    ./script/jlogger-web.pl

If you want to run as FCGI application please read L<starman> documentation.

=back

=head1 AUTHOR

Sergey Zasenko

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011, Sergey Zasenko.

This program is free software, you can redistribute it and/or modify it under
the same terms as Perl 5.10.

=cut
