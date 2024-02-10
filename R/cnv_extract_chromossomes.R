# CROMOSSOMOS INTO INDIVIDUALS DATA FRAMES
cnv_extract_chromossomes <- function(chr_df=cnv, chr_col="seqnames"){
  # progress bar
  maxi <- length(unique(chr_df[[chr_col]]))
  pb <- txtProgressBar(min = 0, max = maxi, style = 3, width = 50, char = "=")

  # loop for the execution
  # For each chromosomes
  for (n in unique(chr_df[[chr_col]])) {
    assign(paste0("chr", as.character(n)), chr_df[chr_df[[chr_col]]==n,], envir= .GlobalEnv)
    # Progress bar
    setTxtProgressBar(pb, n)
  }
  close(pb) # close connection with connection bar
}

