#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use Plack::Response;
use FindBin '$Bin';

use Test::More tests => 15;
use Routes::Tiny;

use JLogger::Web::Renderer;

use_ok 'JLogger::Web::Action';

my $env = {REMOTE_HOST => 'localhost'};

my $config = {config => 'ok'};

my $action = new_ok 'JLogger::Web::Action',
  [ env    => $env,
    params => {action => 'test'},
    config => {config => 'ok', templates_home => "$Bin/templates"},
    renderer => JLogger::Web::Renderer->new(home => "$Bin/templates"),
  ];

is_deeply $action->env, $env, 'env';

is_deeply $action->params, {action => 'test'}, 'params';

is $action->config->{config}, 'ok', 'config';

my $req = $action->req;
is $req->remote_host, $env->{REMOTE_HOST}, 'req';

is $action->req, $req, 'req stored';

my $res = Plack::Response->new(@{$action->render({test => 'ok'})});
is $res->headers->header('Content-Type'), 'text/html';
is $res->body->[0], 'test is ok';

$action->params->{format} = 'html';
$res = Plack::Response->new(@{$action->render({test => 'ok'})});
is $res->headers->header('Content-Type'), 'text/html';
is $res->body->[0], 'test is ok';

$action->params->{format} = 'json';
$res = Plack::Response->new(@{$action->render({test => 'ok'})});
is $res->headers->header('Content-Type'), 'application/json';
is_deeply decode_json $res->body->[0], {test => 'ok'};

# New action for Accept header tests
$action = new_ok 'JLogger::Web::Action',
  [ env => {%$env, HTTP_ACCEPT => 'application/json'},
    params => {action => 'test'},
    config => {config => 'ok', templates_home => "$Bin/templates"},
    renderer => JLogger::Web::Renderer->new(home => "$Bin/templates"),
  ];

$res = Plack::Response->new(@{$action->render({test => 'ok'})});
is $res->headers->header('Content-Type'), 'application/json';
