use inc::Module::Install;

name     'Catalyst-Plugin-Session-Store-CouchDB';
all_from 'lib/Catalyst/Plugin/Session/Store/CouchDB.pm';
author   q{Lenz Gschwendtner <norbu09@cpan.org>};
license  'perl';

requires 'Store::CouchDB';
requires 'Class::Accessor::Fast';
requires 'Class::Data::Inheritable';
requires 'Catalyst::Plugin::Session::Store';

build_requires 'Test::More';

auto_install;

WriteAll;

