ensembl_to_entrez <- function(ensembl_ids, ensembl_dataset = "hsapiens_gene_ensembl", entrez_dataset = "hsapiens_gene_entrezgene", ensembl_column = "Ensembl_ID") {
  mart <- biomaRt::useMart(biomart = "ensembl", dataset = ensembl_dataset)
  ensembl_to_entrez <- biomaRt::getBM(
    attributes = c("ensembl_gene_id", "entrezgene_id"),
    filters = "ensembl_gene_id",
    values = positive_correlations$gene,
    mart = mart
  )
  return(ensembl_to_entrez)
}

inputPosCor <- ensembl_to_entrez(as.vector(positive_correlations$gene))
inputPosCor
