cnv_path_annote<- function(df, entrez_col, organism) {
  entrez_ids <- unique(unlist(df[, entrez_col]))
  pathway_names <- character(length(entrez_ids))

  for (i in 1:length(entrez_ids)) {
    if (length(entrez_ids[[i]]) == 0) {
      pathway_names[[i]] <- NA
    } else {
      gene_symbols <- org.Hs.eg.db::bitr(entrez_ids[[i]], fromType = "ENTREZID", toType = "SYMBOL", organism = organism)
      pathway_names[[i]] <- clusterProfiler::enrichKEGG(gene         = gene_symbols$SYMBOL,
                                                        organism    = organism,
                                                        pvalueCutoff = 0.05,
                                                        qvalueCutoff = 0.2)
    }
  }

  # Mesclar os resultados com o dataframe de entrada
  df$pathway_names <- pathway_names
  return(df)
}
