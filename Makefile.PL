use inc::Module::Install;

name 'JLogger-Web';

all_from 'lib/JLogger/Web.pm';

requires 'Class::Load';
requires 'DBIx::Connector';
requires 'File::Spec';
requires 'JSON';
requires 'List::MoreUtils';
requires 'ObjectDB';
requires 'Plack';
requires 'Routes::Tiny';
requires 'String::CamelCase';
requires 'Text::Caml';
requires 'YAML';

test_requires 'DBD::SQLite';
#test_requires 'JLogger';
test_requires 'Test::More' => '0.88';

WriteAll;
