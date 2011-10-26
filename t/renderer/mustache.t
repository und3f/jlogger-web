#!/usr/bin/env perl

use strict;
use warnings;

use FindBin '$Bin';

use Test::More tests => 10;

use_ok 'JLogger::Web::Renderer::Mustache';

my $renderer = new_ok 'JLogger::Web::Renderer::Mustache',
  [home => "$Bin/../templates"];

my $res = $renderer->render({template => 'test.mt', test => 'ok'}, {});

is $res->[0], 'text/html',  'content-type';
is $res->[1], 'test is ok', 'body';

$res = $renderer->render({template => 'with_layout.mt'}, {});

is $res->[0],   'text/html',                   'content-type';
like $res->[1], qr(<title>nice title</title>), 'title';
like $res->[1], qr(<body>text here</body>),    'body';

$res = $renderer->render({template => 'multi_layout.mt'}, {});
is $res->[0],   'text/html',                   'content-type';
like $res->[1], qr(<title>double layout</title>), 'title';
like $res->[1], qr(<body>foo bar</body>),    'body';
