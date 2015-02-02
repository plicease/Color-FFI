package My::ModuleBuild;

use strict;
use warnings;
use Config;
use ExtUtils::CppGuess;
use base qw( Module::Build::FFI );

sub new
{
  my($class, %args) = @_;
  my $self = $class->SUPER::new(
    ExtUtils::CppGuess->new->module_build_options,
    %args,
  );
  $self;
}

1;
