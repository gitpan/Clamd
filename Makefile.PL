use ExtUtils::MakeMaker;

my $help = `clamd --help 2>&1` || '';
if ($help !~ /clam/i) {
  die "Cannot find clamd in the path - are you sure clamav in installed?\n";
}

WriteMakefile(
    'NAME' => 'Clamd',
    'VERSION_FROM' => 'lib/Clamd.pm',
    'PREREQ_PM' => {},
    'ABSTRACT_FROM' => 'lib/Clamd.pm',
    'AUTHOR' => 'Matt Sergeant <matt@sergeant.org>',
);
