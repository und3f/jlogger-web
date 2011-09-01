#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use Plack::Response;

use Test::More tests => 8;

use_ok 'JLogger::Web::Action';

my $env = {REMOTE_HOST => 'localhost'};

my $action = new_ok 'JLogger::Web::Action',
  [env => $env, params => {action => 'test'}, config => {config => 'ok'}];

is_deeply $action->env, $env, 'env';

is_deeply $action->params, {action => 'test'}, 'params';

is_deeply $action->config, {config => 'ok'}, 'config';

my $res = Plack::Response->new(@{$action->render_json({test => 'ok'})});

is $res->status, 200, 'render_json status';
is $res->headers->header('Content-Type'), 'application/json',
  'render_json content-type';
is_deeply decode_json $res->body->[0], {test => 'ok'}, 'render_json body';
