#!./perl -w

use strict;
use ExtUtils::MakeMaker;
use ObjStore::MakeMaker qw(add_os_args);
require "./HashRecord.pm";

my %args = (
	    NAME         => 'ObjStore::REP::HashRecord',
	    VERSION_FROM => './HashRecord.pm',
	    PL_FILES     => { 'gen_lib.PL' => "osp_hashrecord.h librecord.c" },
	    OBJECT       => 'librecord.o',
	    PM           => { 'HashRecord.pm' => '$(INST_LIBDIR)/HashRecord.pm', 
			     map { $_ => '$(INST_AUTODIR)/'.$_ }
			     'osp_hashrecord.h' },
	    EXE_FILES    => [ 'pl/gen_hashrecord.pl' ],
	    clean        => { FILES => "osp_hashrecord.h librecord.c" },
);

WriteMakefile(add_os_args(%args));

sub MY::postamble {
  'gen_lib.PL :: HashRecord.pm

'
}

package MY;
sub constants {
    my $str = shift->SUPER::constants;
    $str =~ s/^(BASEEXT) =.*$/
	"$1 = libHashRecord".ObjStore::REP::HashRecord::API_VERSION() /me;
    $str;
}
