# function to merge samples and genes symbols/names into a simgle collumn
sample_genes_ids <- function(x1=chr1_cnv, col_sample="samples", col_gene="SYMBOL"){
  
  # PROGRESS BAR
  pb <- txtProgressBar(min = 0,      # Minimum value of the progress bar
                       max = nrow(x1), # Maximum value of the progress bar
                       style = 3,    # Progress bar style (also available style = 1 and style = 2)
                       width = 50,   # Progress bar width. Defaults to getOption("width")
                       char = "=") 
  
  # Loop to create the labels
  sample_genes <- NULL
  for (rows in 1:nrow(x1) ) {
    ids<-paste0(x1[[col_sample]][rows], "_", x1[[col_gene]][rows])
    sample_genes<-rbind(sample_genes, ids)
    
    # Progress bar
    setTxtProgressBar(pb, rows)
  }
  
  close(pb) # close conection with progress bar

  # return a data frame with the column containing samples+genes names
  x2<-cbind(sample_genes, x1)
  rownames(x2)<-NULL
  return(x2) 
}