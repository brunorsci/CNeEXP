cnvr_to_genes_divided<-function(df){
  library(org.Hs.eg.db) # mudar a forma de carregar essa library
  # Dividir o data frame
  n=100
  df_p <- percentiles_df_divide(df = df, n_parts = n)
  if (exists("df_p")) {
    # cnvr to cnv em genes
    for (i in 1:n) {
      assign(paste0("cnvdfdiv_", i), cnvr_to_genes(df = as.data.frame(df_p[i]) , db = org.Hs.eg.db, keytype="ENSEMBL", columns = "SYMBOL"))
    }
  }
  # mesclar os resultados
  cnv_genes=NULL
  if (exists(paste0("cnvdfdiv_", 100))) {
    for (i in 1:100) {
      cnv_genes=rbind(cnv_genes, get(paste0("cnvdfdiv_", i)))
    }
  }
  return(cnv_genes)
}  