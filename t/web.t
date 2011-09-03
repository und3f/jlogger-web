#!/usr/bin/env perl

use strict;
use warnings;

use lib "t/lib";

use Test::More tests => 13;
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
    from => 'sender@server.com/work',
    type => 'message',

    id           => 1,
    message_type => 'chat',
    body         => 'body text',
};
$test_env->storage->store($message);

$test_env->storage->store(
    {   %$message,
        from => 'rec@server.com',
        to   => 'sender@server.com/work',
        body => 'reply',
    }
);

$test_env->storage->store(
    {   %$message,
        from => 'sender@server2.com',
        body => 'body2 text',
    }
);

test_psgi $app, sub {
    my $cb = shift;

    my $res = $cb->(GET '/');
    like $res->content,   qr/sender\@server.com/;
    like $res->content,   qr/rec\@server.com/;
    unlike $res->content, qr/sender\@server2.com/;

    $res = $cb->(GET '/messages');
    like $res->content, qr/body text/;
    like $res->content, qr/body2 text/;

    $res = $cb->(GET '/sender@server.com');
    like $res->content, qr/rec\@server.com/;

    $res = $cb->(GET '/sender@server.com/messages');
    like $res->content, qr/body text/;
    like $res->content, qr/reply/;

    $res = $cb->(GET '/sender@server.com/rec@server.com');
    like $res->content, qr/body text/;
    like $res->content, qr/reply/;
  }
