#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Catalyst::Plugin::Session::Store::CouchDB' );
}

diag( "Testing Catalyst::Plugin::Session::Store::CouchDB $Catalyst::Plugin::Session::Store::CouchDB::VERSION, Perl $], $^X" );
