#!/usr/bin/env plackup

use strict;
use warnings;

use JLogger::Web;

my $jlogger = JLogger::Web->new(config => {database => {source => 'dbi:Pg'}});

$jlogger->init;

$jlogger->to_psgi_app;
