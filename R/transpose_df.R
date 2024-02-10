transpose_df <- function(file){
  df=NULL
  rownames <- colnames(file)
  for (i in 1:ncol(file)) { 
    temp=as.data.frame(t(file[,i]))
    df=rbind(df,temp)
  }
  row.names(df) <- rownames
  return(df)
}