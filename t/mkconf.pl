use Cwd;
open(CONF, ">clamav.conf") || die "Cannot write: $!";

my $dir = cwd;

print CONF <<"EOCONF";
LocalSocket $dir/clamsock
Foreground
MaxThreads 1
ScanArchive
ArchiveMaxFileSize 1M
ArchiveMaxRecursion 1
ArchiveMaxFiles 2
  
EOCONF

close CONF;