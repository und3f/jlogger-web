#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 7;
use JSON;
use FindBin '$Bin';

use_ok 'JLogger::Web::Renderer';

my $renderer = new_ok 'JLogger::Web::Renderer', [home => "$Bin/templates"];

can_ok $renderer, 'render';

my $res = $renderer->render({test => 'ok'}, {format => 'json'});

is $res->[0], 'application/json', 'content-type right';
is_deeply decode_json($res->[1]), {test => 'ok'}, 'data right';

$res =
  $renderer->render({test => 'ok'},
    {template => 'test.mt', format => 'html'});

is $res->[0], 'text/html',  'content-type';
is $res->[1], 'test is ok', 'body';
