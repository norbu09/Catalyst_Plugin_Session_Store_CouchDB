package Catalyst::Plugin::Session::Store::CouchDB;

use strict;
use base qw/
  Class::Accessor::Fast
  Class::Data::Inheritable
  Catalyst::Plugin::Session::Store/;

use MRO::Compat;

use Store::CouchDB;

__PACKAGE__->mk_classdata(qw/_session_couchdb_storage/);

=head1 NAME

Catalyst::Plugin::Session::Store::CouchDB - The great new Catalyst::Plugin::Session::Store::CouchDB!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Catalyst::Plugin::Session::Store::CouchDB;

    my $foo = Catalyst::Plugin::Session::Store::CouchDB->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 function1

=cut

sub get_session_data {
    my ( $c, $sid ) = @_;
    $c->_session_couchdb_storage->get_doc( { id => $sid } );
}

sub store_session_data {
    my ( $c, $sid, $data ) = @_;
    $data->{_id} = $sid;
    $c->_session_couchdb_storage->put_doc( { doc => $data } )
      or Catalyst::Exception->throw("store_session: data too large");
}

sub delete_session_data {
    my ( $c, $sid ) = @_;
    $c->_session_couchdb_storage->del_doc( { id => $sid } );
}

sub delete_expired_sessions { }    # unsupported

sub setup_session {
    my $c = shift;

    $c->maybe::next::method(@_);

    $c->_session_couchdb_storage(
        Store::CouchDB->new(
            host => $c->_session_plugin_config->{host} || '127.0.0.1',
            port => $c->_session_plugin_config->{port} || '5984',
            db   => $c->_session_plugin_config->{db}   || 'session',
        )
    );
}

=head1 AUTHOR

Lenz Gschwendtner, C<< <norbu09 at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-catalyst-plugin-session-store-couchdb at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Plugin-Session-Store-CouchDB>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Catalyst::Plugin::Session::Store::CouchDB


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Catalyst-Plugin-Session-Store-CouchDB>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Catalyst-Plugin-Session-Store-CouchDB>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Catalyst-Plugin-Session-Store-CouchDB>

=item * Search CPAN

L<http://search.cpan.org/dist/Catalyst-Plugin-Session-Store-CouchDB/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010 Lenz Gschwendtner.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of Catalyst::Plugin::Session::Store::CouchDB
