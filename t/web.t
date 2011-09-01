#!/usr/bin/env perl

use strict;
use warnings;

use lib "t/lib";

use Test::More tests => 9;
use Plack::Test;
use HTTP::Request::Common qw(GET);

use TestEnv;
use JSON 'decode_json';

my $test_env = TestEnv->new;

$test_env->init;

use_ok 'JLogger::Web';

my $jlogger_web = new_ok 'JLogger::Web', [config => $test_env->config];

$jlogger_web->init;

ok my $app = $jlogger_web->to_psgi_app, 'Got a plack app';

my $message = {
    to   => 'rec@server.com',
    from => 'sender@server.com',
    type => 'message',

    id           => 1,
    message_type => 'chat',
    body         => 'body text',
};

$test_env->storage->store($message);
$test_env->storage->store({%$message, id => 2, from => 'sender@server2.com'});

test_psgi $app, sub {
    my $cb = shift;

    my $res = $cb->(GET '/accounts');
    my $accounts = decode_json($res->content);
    is scalar @$accounts, 2;
    is_deeply [sort @$accounts], [qw/rec@server.com sender@server.com/];

    $res      = $cb->(GET '/messages/latest');
    my $messages = decode_json($res->content);

    is scalar @$messages, 2;
    is $messages->[0]->{id}, $message->{id}, '/messages/latest';

    $res      = $cb->(GET '/messages/sender@server.com/latest');
    $messages = decode_json($res->content);

    is scalar @$messages, 1;
    is $messages->[0]->{sender}{jid}, 'sender@server.com',
      '/messages/[sender]/latest';
  }
