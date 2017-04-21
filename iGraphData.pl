#!/usr/bin/perl

use strict;
use warnings;

my %fc;
my %p;
my %sym;
my %gene;

open FILE, "<$ARGV[0]" or die "$!\n";
while(<FILE>){
	chomp;
	my ($id,$sym,$fc,$p)=split(/\t/,$_);
	$id=uc($id);
	$sym{$id}=$sym;
	$fc{$id}=$fc;
	$p{$id}=$p;
}
close FILE;



while(<STDIN>){
	chomp;
		#Category    Term    Count   %   Pvalue  Genes   List Total  Pop Hits    Pop Total   Fold Enrichment Bonferroni  Benjamini   FDR
		my ($term,$gene,$value)=split(/\t/,$_);
		my @gene = split(/\, /,$gene);
		if($value <=0.05){
			$term=~s/ /_/g;
			foreach(@gene){
				print "$_\t$sym{$_}\t$term\t$fc{$_}\t$p{$_}\n";
				$gene{$_}="";
			}

		}
}



