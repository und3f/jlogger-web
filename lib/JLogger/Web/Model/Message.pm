package JLogger::Web::Model::Message;

use strict;
use warnings;

use base 'JLogger::Web::Model';

__PACKAGE__->schema->belongs_to(
    'sender',
    foreign_class => 'JLogger::Web::Model::Identificator',
    map           => {sender => 'id'},
  )->belongs_to(
    'recipient',
    foreign_class => 'JLogger::Web::Model::Identificator',
    map           => {recipient => 'id'},
  );

1;
