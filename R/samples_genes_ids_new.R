# function to merge samples and genes symbols/names into a simgle collumn
sample_genes_ids_new <- function(chr_cnv){
  # OBS.: The function expect sample names in vector (column) 1 and genes names in vector (column) 2
  # Loop to create the labels
  sample_genes <- paste0(chr_cnv[1], "_", chr_cnv[2])
  # return a data frame with the column containing samples+genes names
  rownames(sample_genes)<-NULL
  return(sample_genes) 
}