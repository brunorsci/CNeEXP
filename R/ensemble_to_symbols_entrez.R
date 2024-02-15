ensembl_to_symbols<-function(){
  library(org.Hs.eg.db) # mudar a forma de carregar essa library
  symbols=NULL
  for (i in cnvs_seg_new$gene_ids) {
    x <-AnnotationDbi::select(x = org.Hs.eg.db, keys=i, keytype = "ENSEMBL", columns = "entrez_id")
    symbols=rbind(symbols, x)
  }

}
