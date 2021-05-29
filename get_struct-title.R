#setwd("molvis/20201220/")
require(curl)
library(jsonlite)
library(xml2)
args=commandArgs(T)
pdblist=read.table(args[1])[,1]
for ( pdbname in pdblist){
  query=pdbname
  url=paste0("https://data.rcsb.org/rest/v1/core/entry/",pdbname)
  x = fromJSON(url)
  struct_title=x$struct$title
  print(struct_title)
  
}
#For checking XML items
#https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=11914484



