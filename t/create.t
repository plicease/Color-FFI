use strict;
use warnings;
use Test::More tests => 28;
use Color::FFI;

my $color = eval { Color::FFI->new(0,0,0) };
diag $@ if $@;
isa_ok $color, 'Color::FFI';

is $color->get_red,   0, 'red   = 0';
is $color->get_green, 0, 'green = 0';
is $color->get_blue,  0, 'blue  = 0';


$color = eval { Color::FFI->new(1,2,3) };
diag $@ if $@;
isa_ok $color, 'Color::FFI';

is $color->get_red,   1, 'red   = 1';
is $color->get_green, 2, 'green = 2';
is $color->get_blue,  3, 'blue  = 3';


$color = eval { Color::FFI->red; };
diag $@ if $@;
isa_ok $color, 'Color::FFI';

is $color->get_red,   255, 'red   = 255';
is $color->get_green,   0, 'green = 0';
is $color->get_blue,    0, 'blue  = 0';

$color = eval { Color::FFI->green; };
diag $@ if $@;
isa_ok $color, 'Color::FFI';

is $color->get_red,     0, 'red   = 0';
is $color->get_green, 255, 'green = 255';
is $color->get_blue,    0, 'blue  = 0';

$color = eval { Color::FFI->blue; };
diag $@ if $@;
isa_ok $color, 'Color::FFI';

is $color->get_red,     0, 'red   = 0';
is $color->get_green,   0, 'green = 0';
is $color->get_blue,  255, 'blue  = 255';

$color = eval { Color::FFI->black; };
diag $@ if $@;
isa_ok $color, 'Color::FFI';

is $color->get_red,     0, 'red   = 0';
is $color->get_green,   0, 'green = 0';
is $color->get_blue,    0, 'blue  = 0';

$color = eval { Color::FFI->white; };
diag $@ if $@;
isa_ok $color, 'Color::FFI';

is $color->get_red,   255, 'red   = 255';
is $color->get_green, 255, 'green = 255';
is $color->get_blue,  255, 'blue  = 255';

