use utf8;
package JLogger::Web::Schema::Result::Identificator;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JLogger::Web::Schema::Result::Identificator

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

=head1 TABLE: C<identificators>

=cut

__PACKAGE__->table("identificators");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 jid

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "jid",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<jid>

=over 4

=item * L</jid>

=back

=cut

__PACKAGE__->add_unique_constraint("jid", ["jid"]);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2011-12-11 02:55:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FnZ12ZyMcqF42+/HhKbQxA

__PACKAGE__->has_many(
    'involved_messages',
    'JLogger::Web::Schema::Result::Message',
    [{'foreign.sender' => 'self.id'}, {'foreign.recipient' => 'self.id'}]
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
