package Color::FFI;

use strict;
use warnings;
use FFI::Platypus;
use FFI::Platypus::Memory;

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

This module is intended as an example to allow me to experiment with 
L<Module::Build::FFI>, L<FFI::Platypus>.  It isn't intended to be 
useful.

Objects of this class represent a color stored as three 8-bit color 
channel values, red, green and blue.

=head1 CONSTRUCTOR

=head2 new

To create an instance of this class, you can use new, or one of the 
convenience methods.  If you use new you must provide an integer triplet 
of the red, green and blue values.

 my $color = Color::FFI->new(0x7f,0xff,0x00);
 my $red = Color::FFI->red;
 my $green = Color::FFI->green;
 my $blue = Color::FFI->blue;

=head1 METHODS

=head2 white

 my $color = Color::FFI->white;

Class method that returns an instance of L<Color::FFI> that is pure
white.

=head2 black

 my $color = Color::FFI->black;

Class method that returns an instance of L<Color::FFI> that is pure
black.

=head2 red

 my $color = Color::FFI->red;

Class method that returns an instance of L<Color::FFI> that is pure
red.

=head2 get_red

 my $red = $color->get_red;

Return the red color channel as an 8-bit value.

=head2 set_red

 $color->set_red($red);

Sets the red color channel as an 8-bit value.

=head2 green

 my $color = Color::FFI->green;

Class method that returns an instance of L<Color::FFI> that is pure
green.

=head2 get_green

 my $green = $color->get_green;

Return the green color channel as an 8-bit value.

=head2 set_green

 $color->set_green($green);

Sets the green color channel as an 8-bit value.

=head2 blue

 my $color = Color::FFI->blue;

Class method that returns an instance of L<Color::FFI> that is pure
blue.

=head2 get_blue

 my $blue = $color->get_blue;

Return the blue color channel as an 8-bit value.

=head2 set_blue

 $color->set_blue($blue);

Sets the blue color channel as an 8-bit value.

=head1 CAVEATS

It's just an example for testing, it isn't really useful for
anything.

=cut

my $ffi = FFI::Platypus->new;
$ffi->lang('CPP');
$ffi->package;
$ffi->custom_type( Color => {
  native_type => 'opaque',
  perl_to_native => sub { ${ $_[0] } },
  native_to_perl => sub { bless \$_[0], "Color::FFI" },
});

$ffi->attach( [ 'Color::Color(int, int, int)' => '_new' ] => ['Color', 'int', 'int', 'int'] => 'void' );
$ffi->attach( [ 'Color::~Color()' => '_DESTROY'         ] => ['Color']                      => 'void' );

sub _ffi_record_size {
  my $size = $ffi
    ->function( 'Color::_sizeof()' => [] => 'int' )
    ->call;
  die "unable to determine size of Color class"
    unless $size;
  $size;
}

sub new
{
  my $class = shift;
  my $ptr = FFI::Platypus::Memory::malloc(_ffi_record_size());
  my $self = bless \$ptr, $class;
  _new($self, @_);
  $self;
}

foreach my $color (qw( red green blue black white ))
{
  $ffi->attach( [ "Color::${color}()"        => $color        ] => []              => 'Color'  );
  next if $color =~ /^(white|black)$/;
  $ffi->attach( [ "Color::get_${color}()"    => "get_$color"  ] => ['Color']       => 'int'    );
  $ffi->attach( [ "Color::set_${color}(int)" => "_set_$color" ] => ['Color','int'] => 'void'    );
  no strict 'refs';
  *{"set_$color"} = eval qq{ sub { _set_${color}(\@_);\$_[0] } };
  die $@ if $@;
}

sub DESTROY
{
  my($self) = @_;
  _DESTROY($self);
  FFI::Platypus::Memory::free($$self);
}

1;
