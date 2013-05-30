
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "parse directory listing using ftpparse from ftpcopy",
  "AUTHOR" => "Graham Ollis <plicease\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "File-Listing-Ftpcopy",
  "EXE_FILES" => [],
  "LICENSE" => "gpl",
  "NAME" => "File::Listing::Ftpcopy",
  "PREREQ_PM" => {},
  "TEST_REQUIRES" => {
    "POSIX" => 0,
    "Test" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.02_01",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

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

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };


$WriteMakefileArgs{OBJECT} = do {
  my $fd;
  opendir $fd, '.';
  my %obj = map {; $_ => 1 } grep { s/\.(c|xs)$/.o/ } grep !/^\./, readdir $fd;
  closedir $fd;
  join(' ', keys %obj)
};

system $^X, 'typesize.pl';


WriteMakefile(%WriteMakefileArgs);



