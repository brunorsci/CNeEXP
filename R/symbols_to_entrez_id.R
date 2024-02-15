symbols_to_entrez_id<-function(input){
  library(org.Hs.eg.db) # mudar a forma de carregar essa library
  entrez_ids=NULL
  for (i in input) {
    x <-AnnotationDbi::select(x = org.Hs.eg.db, keys=i, keytype = "SYMBOL", columns = "ENTREZID")
    entrez_ids=rbind(entrez_ids, x)
  }
  return(entrez_ids)

}
