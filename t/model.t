#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 6;

use lib "t/lib";

use TestEnv;
my $test_env = TestEnv->new;

$test_env->init;

use_ok 'JLogger::Web::Model';

can_ok 'JLogger::Web::Model', 'conn';

JLogger::Web::Model->conn($test_env->config->{database});

use_ok 'JLogger::Web::Model::Identificator';

my $identificator = new_ok 'JLogger::Web::Model::Identificator';

use_ok 'JLogger::Web::Model::Message';

my $message = new_ok 'JLogger::Web::Model::Message';
