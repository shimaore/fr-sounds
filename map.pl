#!/usr/bin/env perl
#
use strict; use warnings;
while(<>) {
  chomp;
  my ($loc,$n) = split(/\t/);
  $n = sprintf('%03d',$n);
  my @loc = split(/\//,$loc);
  my $file = pop(@loc);
  for my $rate (8000,16000,32000,48000) {
    my @dir = (qw(fr fr sibylle),@loc,$rate);
    my $src = join('/',qw(wav),$rate,"$n.wav");
    my $dst = join('/',@dir,$file);
    die $src unless -e $src;
    print "Moving $src to $dst\n";
    my @pop = ();
    while(!-d join('/',@dir)) {
      push(@pop,pop(@dir));
    }
    while(@pop) {
      push(@dir,pop(@pop));
      my $dir = join('/',@dir);
      print "Mkdir $dir\n";
      mkdir $dir or die $dir;
    }
    unlink $dst or warn $dst;
    link $src, $dst or die $dst;
  }
}

