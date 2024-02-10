library(org.Hs.eg.db)

# Carregar a library
cl <- parallel::makeCluster(parallel::detectCores()-2) 
doParallel::registerDoParallel(cl)

# Funcao a ser executada em paralelo
cnvr_to_genes_individual_input<-function(X){
  X <- as.data.frame(X)
  results<-NULL
  tryCatch({
    temp1 <- select(x = org.Hs.eg.db, keys=unlist(X[["gene_ids"]]), keytype = "ENSEMBL", columns = "SYMBOL")
    temp2 <- as.data.frame(temp1)
    results <- cbind(X, temp2) # Retorna cada gene com as informacoes de cnvr em unica linha
    return(results)
    stop("")
  }, error=function(e){})# Errors are ignored and no messages are shown!
  return(results)
}

# Dividir em partes para ser executada em paralelo
parts <- NULL
for (i in 1:length(teste$gene_ids)) {
  parts[[i]] <- teste[i,]
}

# testar a funcao cnvr_to_genes_individual_input
teste=cnvr_to_genes_individual_input(X = parts[1])

# Testar se a funcao individual executaria corretamente dentro de um loop for
for (i in parts) {
  cnvr_to_genes_individual_input(X = i)
}

# executar o loop
teste=foreach::foreach(n=parts) %dopar% # parallel
  cnvr_to_genes_individual_input(X = n)


