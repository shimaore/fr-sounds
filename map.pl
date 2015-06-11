#!/usr/bin/env perl
#
use strict; use warnings;
my $src_dir = shift;
while(<>) {
  chomp;
  my ($loc,$n) = split;
  $n = sprintf('%03d',$n);
  my @loc = split(/\//,$loc);
  my $file = pop(@loc);
  for my $rate (8000,16000,32000,48000) {
    my @dir = (qw(fr fr sibylle),@loc,$rate);
    my $src = join('/',$src_dir,$rate,"$n.wav");
    my $dst = join('/',@dir,"$file.wav");
    die $src unless -e $src;
    print "Creating @dir\n";
    my @pop = ();
    while($#dir > -1 and !-d join('/',@dir)) {
      push(@pop,pop(@dir));
    }
    while(@pop) {
      push(@dir,pop(@pop));
      my $dir = join('/',@dir);
      print "Mkdir $dir\n";
      mkdir $dir or die $dir;
    }
    print "Moving $src to $dst\n";
    unlink $dst; # or warn $dst;
    link $src, $dst or die $dst;
  }
}
