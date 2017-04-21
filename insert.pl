#!/usr/bin/perl

use strict;
use warnings;

my %up;
my %down;
my %gene;
open FILE, "<id_map.txt" or die "$!\n";
while(<FILE>){
	chomp;
	my ($symbol,$gene)=split(/\t/,$_);
	$gene{$gene}=$symbol;
}
close FILE;


open FILE, "<$ARGV[0]" or die "$!\n";
while(<FILE>){
	chomp;
	if($. == 1){next;}
	#Gene logFC	FDR
	my ($gene,$other)=split(/\t/,$_,2);
	$gene=uc($gene);
	if(defined $gene{$gene}){
		print "$gene\t$gene{$gene}\t$other\n";
	}
	else{
		print "$gene\tNA\t$other\n";
	}
	
}
close FILE;
