#!/usr/bin/perl

use strict;
use warnings;
use XML::Simple;

my $poolfile = '/Users/steve/Development/AmateurExtra/aecli/Extra.txt';
our $count = 0;
our $questions = {
  'question' => [],
};

# Open the file
open my $fh, '<'. $poolfile or die "Unable to open $poolfile: $!\n";
#undef $/;
#my $pool = <$fh>;
my $inq = 0;
my $qbuffer = '';
line:
while(my $line = <$fh>) {
  last if $count > 10;
  $line =~ s/^\s+//;
  $line =~ s/\s+$//;
  if($inq) {
    if($line eq '~~') {
      $qbuffer .= "\n";
      $inq = 0;
      #print "\r\n" if $count;
      process_question($qbuffer);
      next line;
    }
    $qbuffer .= "\n" . $line;
    next line;
  } else {
    if($line =~ /^E\d\D\d\d\s*\(.\)/) {
      $qbuffer = $line;
      $inq = 1;
    }
    next line;
  }
}
close $fh;

print XMLout($questions, RootName => 'questions');

sub process_question {
  my ($qbuffer) = @_;
  
  chomp($qbuffer);
  $qbuffer =~ tr/"/'/;
  if($qbuffer =~ /^(E\d\D\d\d)
  \s*
  \((.)\)
  [^\n]*\n
  (.+)
  \nA.\s+(.+)
  \nB.\s+(.+)
  \nC.\s+(.+)
  \nD.\s+(.+)
  /xms
  ) {
  my $qid = $1;
  my $answer = $2;
  my $question = $3;
  my $ansA = $4;
  my $ansB = $5;
  my $ansC = $6;
  my $ansD = $7;
  
  $question =~ s/\n/ /g;
  $ansA =~ s/\n/ /g;
  $ansB =~ s/\n/ /g;
  $ansC =~ s/\n/ /g;
  $ansD =~ s/\n/ /g;
  
  push @{$questions->{'question'}}, {
    'question' => $question,
    'answer'   => $answer,
    'id'       => $qid,
    'A'        => $ansA,
    'B'        => $ansB,
    'C'        => $ansC,
    'D'        => $ansD,
  };
  
#  print "ID: $qid\n";
#  print "QUESTION: $question\n";
#  print "A: $ansA\n";
#  print "B: $ansB\n";
#  print "C: $ansC\n";
#  print "D: $ansD\n";
#  print "ANSWER: $answer\n";
#  print "~~\n";
  }
}