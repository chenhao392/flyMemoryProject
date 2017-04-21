library("plotrix")
library("igraph")

  set.seed(392)
  dataIn<-read.table(file="iGraph_data.txt",sep="")

  data<-dataIn[,c(2,3,4,5)]
  data$V3<-gsub("~","\n\n",data$V3)
  data$V3<-gsub("(\\d):","\\1\n\n",data$V3)
  data$V3<-gsub(",.*","",data$V3)
  data$V3<-gsub("(.{8,30}?)_","\\1\n\n",data$V3,perl = T)
  
  g <- graph.data.frame(as.data.frame(data),directed=F)
  nGENE<-length(unique(data$V2))
  nANNO<-length(unique(data$V3))


  colorDF<-unique(subset(data,select=c(V2,V4)))
  geneColor<-color.scale(colorDF$V4,cs1=c(0,1),cs2=c(0,0),cs3=c(1,0),alpha=1,
            extremes=NA,na.color=NA,xrange=NULL,color.spec="rgb")

  V(g)$label.cex<-c(rep(0.05,nGENE),rep(0.0315,nANNO))
  #V(g)$name<-c(rep("",nGENE+nANNO))
  V(g)$label.color<-c(rep("black",nGENE+nANNO))
  V(g)$color <- c(geneColor,rep("darkgray",nANNO))
  V(g)$size<-c(rep(2,nGENE),rep(3,nANNO))
  #V(g)$size2<-c(rep(2,nGENE),rep(1.5,nANNO))
  #V(g)$shape<-c(rep("circle",nGENE),rep("rectangle",nANNO))
  V(g)$shape<-c(rep("circle",nGENE),rep("circle",nANNO))
  V(g)$frame.color<-c(geneColor,rep("darkgray",nANNO))
  
  E(g)$width<-c(rep(0.2,798))

  layout<-layout.fruchterman.reingold(g, niter=10000)
    par(mar=c(7,4,4,6))
    par(mar=c(0,0,0,0))
    plot.igraph(g,layout=layout,vertex.label.dist=0.0)
    ruler<-color.scale(seq(1,8,0.5),cs1=c(0,1),cs2=c(0,0),cs3=c(1,0),alpha=1,
                       extremes=NA,na.color=NA,xrange=NULL,color.spec="rgb")
    color.legend(0.2,0.95,0.7,1,c("1","8"),ruler)
    
