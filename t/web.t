#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use lib "t/lib";

use Test::More tests => 16;
use Plack::Test;
use HTTP::Request::Common qw(GET);

use TestEnv;
use JSON 'decode_json';

my $test_env = TestEnv->new;

$test_env->init;

use_ok 'JLogger::Web';

my $jlogger_web = new_ok 'JLogger::Web',
  [config => {%{$test_env->config}, messages_per_page => 3}];

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

my $storage = $test_env->storage;
$storage->store({%$message, id => 'all1'});

$storage->store(
    {   %$message,
        from => 'rec@server.com',
        to   => 'sender@server.com/work',
        body => 'reply',
    }
);

$message->{from} = 'sender@server2.com';
$storage->store({%$message, body => 'body2 text', id => 'all2'});
$storage->store({%$message, body => 'привет',});
$storage->store({%$message, body => 'one more',});

$storage->store(
    {   %$message,
        body => 'page test',
        id   => 'ptest',
    }
);

$test_env->dbh->do(<<'SQL');
UPDATE messages
SET timestamp = datetime('now', '-2 minutes')
WHERE id = 'ptest'
SQL

$test_env->dbh->do(<<'SQL');
UPDATE messages
SET timestamp = datetime('now', '+2 minutes')
WHERE id = 'all1' OR id = 'all2'
SQL

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

    $res = $cb->(GET '/rec@server.com/sender@server2.com');
    my $content = $res->content;
    utf8::decode($content);
    like $content, qr/привет/;

    $res = $cb->(
        GET '/rec@server.com/sender@server2.com?page=2',
        Accept => 'application/json'
    );

    $content = decode_json $res->content;
    my @messages = @{$content->{messages}};

    is scalar @messages, 1;
    is $messages[0]->{id}, 'ptest';
  }
