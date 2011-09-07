#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use Plack::Response;
use FindBin '$Bin';

use Test::More tests => 21;
use Routes::Tiny;

use_ok 'JLogger::Web::Action';

my $env = {REMOTE_HOST => 'localhost'};

my $action = new_ok 'JLogger::Web::Action',
  [ env    => $env,
    params => {action => 'test'},
    config => {config => 'ok', templates_home => "$Bin/templates"}
  ];

is_deeply $action->env, $env, 'env';

is_deeply $action->params, {action => 'test'}, 'params';

is $action->config->{config}, 'ok', 'config';

my $req = $action->req;
is $req->remote_host, $env->{REMOTE_HOST}, 'req';

is $action->req, $req, 'req stored';

my $res = Plack::Response->new(@{$action->render_json({test => 'ok'})});

is $res->status, 200, 'render_json status';
is $res->headers->header('Content-Type'), 'application/json',
  'render_json content-type';
is_deeply decode_json $res->body->[0], {test => 'ok'}, 'render_json body';

$res = Plack::Response->new(@{$action->render_html({test => 'ok'})});
is $res->status, 200, 'render_html status';
is $res->headers->header('Content-Type'), 'text/html',
    'render_html content-type';
is $res->body->[0], 'test is ok', 'render_html body';

$res = Plack::Response->new(@{$action->render({test => 'ok'})});
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
  [ env    => {%$env, HTTP_ACCEPT => 'application/json'},
    params => {action => 'test'},
    config => {config => 'ok', templates_home => "$Bin/templates"}
  ];

$res = Plack::Response->new(@{$action->render({test => 'ok'})});
is $res->headers->header('Content-Type'), 'application/json';
