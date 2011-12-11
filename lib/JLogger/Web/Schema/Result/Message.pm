use utf8;
package JLogger::Web::Schema::Result::Message;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JLogger::Web::Schema::Result::Message

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<messages>

=cut

__PACKAGE__->table("messages");

=head1 ACCESSORS

=head2 sender

  data_type: 'integer'
  is_nullable: 1

=head2 sender_resource

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 recipient

  data_type: 'integer'
  is_nullable: 1

=head2 recipient_resource

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 body

  data_type: 'text'
  is_nullable: 1

=head2 thread

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 timestamp

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sender",
  { data_type => "integer", is_nullable => 1 },
  "sender_resource",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "recipient",
  { data_type => "integer", is_nullable => 1 },
  "recipient_resource",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "id",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "body",
  { data_type => "text", is_nullable => 1 },
  "thread",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "timestamp",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2011-12-11 02:55:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bkRGmi+JLWWN/T4uNM/lWA

__PACKAGE__->belongs_to('sender',
    'JLogger::Web::Schema::Result::Identificator', 'sender');
__PACKAGE__->belongs_to('recipient',
    'JLogger::Web::Schema::Result::Identificator', 'recipient');

1;
