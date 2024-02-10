null.remove<-function(df, col){
  n=NULL
  for (i in 1:nrow(df)) {
    if (is.null(df[[col]][i])==TRUE) {
      n=c(as.numeric(n),as.numeric(i))
    }
  }
  df<-df[-c(n),]
  rownames(df)<-NULL
  return(df)
}
