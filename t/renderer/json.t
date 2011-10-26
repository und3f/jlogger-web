#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use Test::More tests => 4;

use_ok 'JLogger::Web::Renderer::JSON';

my $renderer = new_ok 'JLogger::Web::Renderer::JSON';

my $res = $renderer->render({test => 'ok'});

is $res->[0], 'application/json', 'content-type right';
is_deeply decode_json($res->[1]), {test => 'ok'}, 'data right';
