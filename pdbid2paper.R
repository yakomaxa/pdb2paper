args=commandArgs(T)
#setwd("molvis/20201220/")
require(curl)
library(jsonlite)
require(xml2)
head='https://data.rcsb.org/graphql?query=%7B%0A%20%20entries(entry_ids:%20%5B%22'
tail='%22%5D)%20%7B%0A%20%20%20%20rcsb_id%0A%20%20%20%20rcsb_accession_info%20%7B%0A%20%20%20%20%20%20initial_release_date%0A%20%20%20%20%7D%0A%20%20%20%20audit_author%20%7B%0A%20%20%20%20%20%20name%0A%20%20%20%20%7D%0A%20%20%20%20rcsb_primary_citation%20%7B%0A%20%20%20%20%20%20pdbx_database_id_PubMed%0A%20%20%20%20%20%20pdbx_database_id_DOI%0A%20%20%20%20%7D%0A%20%20%7D%0A%7D'
pdbname=args[1]
query=pdbname
url=paste0(head,query,tail)
x = fromJSON(url)
PUBMEDID=x$data$entries$rcsb_primary_citation$pdbx_database_id_PubMed
print(paste(x$data$entries$rcsb_primary_citation$pdbx_database_id_PubMed,
            x$data$entries$rcsb_primary_citation$pdbx_database_id_DOI))
yubis=paste0("https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=",PUBMEDID)
x = read_xml(yubis)
journal = xml_text(xml_find_all(x, "//Item[@Name='Source']"))
title = xml_text(xml_find_all(x, "//Item[@Name='Title']"))
print(paste(journal,"\n",title))

#For checking XML items
#https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=11914484

#pdb-url
#https://data.rcsb.org/#rest-api

