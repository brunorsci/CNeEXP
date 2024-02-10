cnv_individual_chromossomes <- function(n=22,dataf=cnv, chr_colx="seqnames", genes_colz="gene_ids"){
  # PROGRESS BAR
  x=dataf
  y=chr_colx
  for (i in 1:n) {
    assign(paste0("chr",i), cnv_extract_chromossomes(chr_df=x, chr_col=y))
    assign(paste0("chr",i), cnvr_to_genes(df = paste0("chr",i), col = genes_colz))
    assign(paste0("chr",i), paste0("chr",i)[,-10]) # remover a coluna genes_ids
    saveRDS(object = paste0("chr",i), file = paste0("chr",i,".rds"))
    write.table(x = paste0("chr",i), file = paste0("chr",i,"_cnvs.rds"), quote = F, row.names = F)
  }
}
