#!/usr/bin/env plackup

use strict;
use warnings;

use File::Basename;
use File::Spec::Functions;
use Plack::Builder;
use YAML;

use JLogger::Web;

my $home        = catfile(dirname(__FILE__), '..');
my $static      = catfile($home,             'public');
my $config_file = catfile($home,             'jlogger-web.yaml');

my $config = YAML::LoadFile($config_file);
$config->{templates_home} ||= catfile($home, 'templates');

my $jlogger = JLogger::Web->new(config => $config);

$jlogger->init;

builder {
    enable 'Plack::Middleware::Static',
      path => qr{^/(images|js|css)/},
      root => $static;

    $jlogger->to_psgi_app;
}
