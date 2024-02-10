# Instalar e carregar os pacotes necessários
install.packages("doParallel")
library(doParallel)

# Definir o número de núcleos desejados para a paralelização
num_cores <- 6

# Criar o cluster de núcleos
cl <- makeCluster(num_cores)

# Registrar o cluster para uso com foreach
registerDoParallel(cl)

# Loop for paralelizado usando foreach
foreach(i = 14:16) %dopar% {
  cat("Iteração", i, "executada no núcleo", Sys.getpid(), "\n")
  assign(paste0("parte_", i, "annotated"), cnv_annote(input = as.data.frame(divide[i]), ref_genome = "hg19"))
}

# Encerrar o cluster de núcleos
stopCluster(cl)
