# Color::FFI

example color class written using Module::Build::FFI

# SYNOPSIS

    my $color = Color::FFI->new(255,255,255); # same as Color::FFI->white;
    $color->set_green(75);
    $color->set_blue(100);
    say "red is ", $color->get_red;
    say "green is ", $color->get_green;
    say "blue is ", $color->get_blue;

# DESCRIPTION

This module is intended as an example to allow me to experiment
with [Module::Build::FFI](https://metacpan.org/pod/Module::Build::FFI), [FFI::Raw](https://metacpan.org/pod/FFI::Raw) and [FFI::Sweet](https://metacpan.org/pod/FFI::Sweet).  It isn't
intended to be useful.

Objects of this class represent a color stored as three 8-bit color
channel values, red, green and blue.

# CONSTRUCTOR

To create an instance of this class, you can use new, or one of the
convenience methods.  If you use new you must provide an integer 
triplet of the red, green and blue values.

    my $color = Color::FFI->new(0x7f,0xff,0x00);
    my $red = Color::FFI->red;
    my $green = Color::FFI->green;
    my $blue = Color::FFI->blue;

# METHODS

## $color->get\_red

Return the red color channel as an 8-bit value.

## $color->get\_green

Return the green color channel as an 8-bit value.

## $color->get\_blue

Return the blue color channel as an 8-bit value.

# CAVEATS

It's just an example for testing, it isn't really useful for
anything.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
