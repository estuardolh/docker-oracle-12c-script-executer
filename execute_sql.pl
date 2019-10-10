#!/usr/bin/perl

# elh 2019

use strict;
use warnings;

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub readTextFile {
  my $text = '';
  my $filename = $_[0];
  if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
    while (my $row = <$fh>) {
      chomp $row;
      $text = $text."$row\n";
    }
  } else {
    warn "Could not open file '$filename' $!";
  }
  return $text;
}

sub saveTextFile {
  open(my $fh, '>:encoding(UTF-8)', $_[0])
    or die "Could not open file '$_[0]'";
  print $fh $_[1];
  close $fh;
}

sub readScriptList {
  my $scripts = readTextFile('/stage/scripts/script_list.txt');
  my @listScript = split /\n/, $scripts;
  return @listScript;
}

sub executeSqlAndLogexecuteSqlAndLog {
  my $log = `sqlplus system/oracle << EOF
SET ECHO ON
SET VERIFY ON
--SET TRIMOUT ON
SET FEEDBACK ON
--SERVEROUTPUT ON
--SET TRIMSPOOL OFF
SET PAGESIZE 1024
SET LINESIZE 1024
--SET TERM ON
--SET HEADING OFF
WHENEVER SQLERROR EXIT 1
SPOOL script.log
$_[0]
SPOOL OFF
EOF`;
  
#  saveTextFile("scripts.log", "$log");

  return "$log";
}

sub main {
  my @scriptList = readScriptList();
  my $scriptListSql = "";
  my $aScript;

  foreach $aScript (@scriptList){
    $scriptListSql = $scriptListSql."@/stage/scripts/$aScript\n";
  }

  print $scriptListSql;

  my $log = executeSqlAndLog("$scriptListSql");
  print "$log";
}

print "~ start.\n";
print "  \n";

main();
