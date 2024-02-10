mudar_identificador_tcga<-function(x){
   partes <- strsplit(x, "_")[[1]]
   novo_identificador <- paste(partes[1:3], collapse = "_")
   return(novo_identificador)
 }
