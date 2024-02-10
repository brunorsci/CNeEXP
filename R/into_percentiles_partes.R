into_percentiles_partes=function(list){
  perc <- NULL
  for (i in 1:10) {
    i <- i/10
    perc <- c(perc , quantile(c(1:nrow(list)), probs =i))
    print(perc)
  }
  perc_1 <- list[c(1:perc[1]), ]

}

cnv_19_hg37_annotated <- cnv_annote(input = grange, ref_genome = "hg19")
