use strict;
use Test;
BEGIN { plan tests => 3 }
use Clamd;

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
ok($clamd->ping);

ok(kill(9 => $pid), 1);
waitpid($pid, 0);
unlink("clamsock");
