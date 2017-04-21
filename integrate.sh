#script run in OSX
perl insert.pl edgeR_out.txt >edgeR_out.txt.ins
grep -Ev "^Anno" DAVID_out.txt    |grep -Ev "Cate"|grep -Ev "^$" |sort -t$'\t' -k3nr|cut -f2,6,11|perl iGraphData.pl edgeR_out.txt.ins >iGraph_data.txt
rm -f edgeR_out.txt.ins
