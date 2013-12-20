package Color::FFI;

use strict;
use warnings;
use FFI::Sweet;

# ABSTRACT: example color class written using Module::Build::FFI
# VERSION

=head1 SYNOPSIS

 my $color = Color::FFI->new(255,255,255); # same as Color::FFI->white;
 $color->set_green(75);
 $color->set_blue(100);
 say "red is ", $color->get_red;
 say "green is ", $color->get_green;
 say "blue is ", $color->get_blue;

=head1 DESCRIPTION

This module is intended as an example to allow me to experiment
with L<Module::Build::FFI>, L<FFI::Raw> and L<FFI::Sweet>.  It isn't
intended to be useful.

Objects of this class represent a color stored as three 8-bit color
channel values, red, green and blue.

=head1 CONSTRUCTOR

To create an instance of this class, you can use new, or one of the
convenience methods.  If you use new you must provide an integer 
triplet of the red, green and blue values.

 my $color = Color::FFI->new(0x7f,0xff,0x00);
 my $red = Color::FFI->red;
 my $green = Color::FFI->green;
 my $blue = Color::FFI->blue;

=head1 METHODS

=head2 $color-E<gt>get_red

Return the red color channel as an 8-bit value.

=head2 $color-E<gt>get_green

Return the green color channel as an 8-bit value.

=head2 $color-E<gt>get_blue

Return the blue color channel as an 8-bit value.

=head1 CAVEATS

It's just an example for testing, it isn't really useful for
anything.

=cut

ffi_lib do {
  my($module, $modlibname) = ('Color::FFI', __FILE__);
  my @modparts = split(/::/,$module);
  my $modfname = $modparts[-1];
  my $modpname = join('/',@modparts);
  my $c = @modparts;
  $modlibname =~ s,[\\/][^\\/]+$,, while $c--;    # Q&D basename
  my $file = "$modlibname/auto/$modpname/$modfname.so";
  unless(-e $file)
  {
    $modlibname =~ s,[\\/][^\\/]+$,,;
    $file = "$modlibname/arch/auto/$modpname/$modfname.so"
  }
  \$file;
};

attach_function [ 'c_new' => 'new' ], [ _int, _int, _int ], _ptr, sub
{
  my($cb, $class, $r, $g, $b) = @_;
  my $self = \($cb->($r, $g, $b));
  bless $self, $class;
};

attach_function [ 'c_DESTROY' => 'DESTROY' ], [ ], _void, sub
{
  my($cb, $self) = @_;
  $cb->($self);
  return;
};

1;
