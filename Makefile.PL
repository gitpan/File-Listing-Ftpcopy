
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
  "VERSION" => "0.05",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "POSIX" => 0,
  "Test" => 0,
  "Test::More" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
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



