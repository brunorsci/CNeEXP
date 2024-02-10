cnvr_to_genes<- function(df=teste, col="gene_ids", db=org.Hs.eg.db, keytyp="ENSEMBL", column = "SYMBOL"){
  library(org.Hs.eg.db) # mudar a forma de carregar essa library

  # progress bar
  pb <- txtProgressBar(min = 0, max = length(df[[col]]), style =3, width = 50, char = "=")

  # loop for execution

  results=NULL
  for (i in 1:length(df[[col]]) ) {
    suppressMessages({# amazing. Use this and other functions!
    tryCatch({
    temp1 <- select(x = db, keys=unlist(df[[col]][i]), keytype = keytyp, columns = column)
    temp2=as.data.frame(temp1)
    row.names(temp2)<-NULL
    tempf <- cbind(df[i,], temp2) # Return each genes in unique rows
    results <-rbind(results, tempf)
    stop("")
    }, error=function(e){})# Errors are ignored and no messages are shown!
    setTxtProgressBar(pb, i)
    })
  }
  close(pb) # close connection with progress bar
  return(results)
}
