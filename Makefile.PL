use ExtUtils::MakeMaker;
use v5.10.1;



my %args = (
  NAME => 'File::Listing::Ftpcopy',
  'ABSTRACT' => 'parse directory listing using ftpparse from ftpcopy',
  'AUTHOR' => 'Graham Ollis <plicease@cpan.org>',
  'LICENSE' => 'gpl',
  'VERSION' => '0.01',
  'BUILD_REQUIRES' => {
    'POSIX' => '0',
    'Test' => '0',
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  OBJECT => do {
    opendir $fd, '.';
    my %obj = map {; $_ => 1 } grep { s/\.(c|xs)$/.o/ } grep !/^\./, readdir $fd;
    closedir $fd;
    join(' ', keys %obj)
  }
);

system $^X, 'typesize.pl';

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}
 
delete $args{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };
 
delete $args{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };
 
WriteMakefile(%args);
 

