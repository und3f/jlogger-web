package JLogger::Web::Model;

use strict;
use warnings;

use base 'ObjectDB';

use DBIx::Connector;

our $CONN;

sub conn {
    my ($class, $db_config) = @_;

    return $CONN unless $db_config;

    my ($source, $username, $password, $attr) =
      @{$db_config}{qw/source username password attr/};
    $attr ||= {};

    $CONN = DBIx::Connector->new(
        $source,
        $username,
        $password,
        {   RaiseError => 1,
            ReadOnly   => 1,
            %$attr
        }
    );
    die $DBI::errorstr unless $CONN;
}

sub dbh {
    return $CONN->dbh;
}

1;
