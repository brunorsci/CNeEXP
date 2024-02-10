# Conectar ao banco de dados usando o biomaRt
mart <- biomaRt::useMart(biomart = "ensembl", dataset = organism)
entrez_ids <- mcols(cnv_granges)$ENTREZ_ID

gene_name <- list()

for (i in 1:7) {
  if (length(entrez_ids[[i]]) == 0) {
    gene_name[[i]] <- paste0("NA")
  } else {
    h <- getBM(attributes = c("ensembl_gene_id", "external_gene_name"),
               filters = "entrezgene_id",
               values = unique(entrez_ids[[i]]),
               mart = mart)
    gene_name[[i]] <- paste(h$external_gene_name, collapse = ", ")
  }
}

# Atribuindo aos GRanges
granges$gene_name <- unlist(gene_name)

