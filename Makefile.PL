use inc::Module::Install;

name 'JLogger-Web';

all_from 'lib/JLogger/Web.pm';

requires 'Class::Load';
requires 'DBIx::Class';
requires 'DBIx::Class::InflateColumn::DateTime';
requires 'DBIx::Connector';
requires 'File::Spec';
requires 'JSON';
requires 'Plack';
requires 'Routes::Tiny';
requires 'String::CamelCase';
requires 'Text::Caml' => '0.009004';
requires 'YAML';

test_requires 'DateTime::Format::SQLite';
test_requires 'DBD::SQLite';

#test_requires 'JLogger';
test_requires 'Test::More' => '0.88';

WriteAll;
