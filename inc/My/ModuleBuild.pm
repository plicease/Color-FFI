package My::ModuleBuild;

use strict;
use warnings;
use Config;
use base qw( Module::Build::FFI );

sub new
{
  my($class, %args) = @_;
  
  $args{extra_compiler_flags} = '-fkeep-inline-functions';  # g++ only
  $args{extra_linker_flags}   = '-lstdc++';                 # probably also compiler dependent
  
  my $self = $class->SUPER::new(%args);

  $self->config( cc => 'gcc' ) if $Config{cc} =~ /clang/; # clang does not support -fkeep-inline-functions
  
  $self;
}

1;
