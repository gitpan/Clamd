use strict;
use Test;
use constant SKIP => $^O eq 'linux';
BEGIN { plan tests => SKIP ? 0 : 4 }
SKIP and print "# Skipping - clamd too broken on linux\n";
use Clamd;
SKIP and exit(0);

do "t/mkconf.pl";

# start clamd
my $pid = fork;
die "Fork failed" unless defined $pid;
if (!$pid) {
    exec "clamd -c clamav.conf";
}
for (1..10) {
  last if (-e "clamsock");
  sleep(1);
}

my $clamd = Clamd->new(port => "clamsock");
ok($clamd);
ok($clamd->quit);
ok($clamd->ping, '', "Ping succeeded after quit");
sleep(1);
waitpid($pid, 0);

ok(kill(9 => $pid), 0);
unlink("clamsock");
