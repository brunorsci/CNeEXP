# Function to teste the correlation between cnvs genes and gene expression
# Methodx= "pearson", "kendall", "spearmam".
# df= dataframe com uma coluna com os genes e as contagens de segment e read count
# gene_ids_col= coluna que contem os genes
cnv_exp_correlation <- function(df=z, x_col="segment_mean", y_col="normalized_read_count", gene_ids_col="gene_id", methodx="spearman"){
  #progress bar
  pb <- txtProgressBar(min = 0, max = length(df[[gene_ids_col]]), style = 3, width = 50, char = "=")
  # function to execution
  correlation_results<-NULL
  for (gene in unique(df[[gene_ids_col]])) {
    # progres bar shown
    setTxtProgressBar(pb, gene)
    # Calculation
    x1        <- df[df[[gene_ids_col]]==gene,]
    cor       <- cor.test(x=x1[[x_col]], y=x1[[y_col]], method = methodx)
    statistic <- cor$statistic
    estimate  <- cor$estimate
    p_value   <- cor$p.value
    method    <- cor$method
    # results
    res <- cbind(gene, statistic, estimate , p_value, method)
    rownames(res) <- NULL
    correlation_results <- rbind(correlation_results, res)
  }
  close(pb)
  return(correlation_results)
}
#In the output:

#S is the value of the test statistic (S = 10.871)
#p-value is the significance level of the test statistic (p-value = 0.4397).
#alternative hypothesis is a character string describing the alternative hypothesis (true rho is not equal to 0).
#sample estimates is the correlation coefficient. For Spearman correlation coefficient it’s named as rho (Cor.coeff = 0.4564).
