use inc::Module::Install;

name 'JLogger-Web';

all_from 'lib/JLogger/Web.pm';

requires 'Class::Load';
requires 'JSON';
requires 'ObjectDB';
requires 'Routes::Tiny';
requires 'String::CamelCase';
requires 'Text::Caml';
requires 'YAML';

test_requires 'JLogger';
test_requires 'DBD::SQLite';

WriteAll;
