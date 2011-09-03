package TestEnv;

use strict;
use warnings;

use FindBin '$Bin';
use File::Temp;
use DBI;

use lib "$Bin/../contrib/jlogger/lib";
use JLogger::Storage::DB;

sub new {
    bless {config =>
          {domain => 'server.com', templates_home => "$Bin/../templates"}
    }, shift;
}

sub init {
    my $self = shift;

    my $db_file = File::Temp->new;

    $self->{db_file} = $db_file;

    $self->config->{database} =
      {source => 'dbi:SQLite:' . $db_file->filename};

    # Load database schema
    my $schema_file = "$Bin/../contrib/jlogger/schema/database.sqlite.sql";

    open my $fh, '<:encoding(UTF-8)', $schema_file
      or die qq(Can't open schema "$schema_file": $!);
    my $schema = do { local $/; <$fh> };
    close $fh;

    my $dbh = $self->{dbh} =
      DBI->connect($self->config->{database}->{source});
    $dbh->{RaiseError} = 1;
    my @sql = split /\s*;\s*/, $schema;
    $dbh->do($_) foreach @sql;

    # JLogger::Storage::DB for testing purpose
    $self->{storage} =
      JLogger::Storage::DB->new(
        source => $self->config->{database}->{source});

}

sub config { $_[0]->{config} }

sub dbh { $_[0]->{dbh} }

sub storage { $_[0]->{storage} }

1;
