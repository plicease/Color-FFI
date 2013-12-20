package Color::FFI;

use strict;
use warnings;
use FFI::Sweet;

# ABSTRACT: example color class written using Module::Build::FFI
# VERSION

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
