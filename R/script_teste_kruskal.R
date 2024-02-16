# Primeiro vamos realizar uma filtragem pelos genes de interesse.

genesAML <- c("KIT", "KITLG", "GRB2", " SOS","RAS","STAT","PI3","RAF",
              "JAK","PIP","PKB","MTOR","MEK","MAPK","IKK","BAD","ERK","p7026k","PIM",
              "EBP", "CEBP","PU", "RUNX1", "ETO", "PML","TRIM", "MYL", "PML", "RAR","CSF",
              "GMCSF","PER2","CSF","CD14","CD64","CYC","MYC","DUSP","PPAR","TCF","JUP")
genesAML <- unique(genesAML)

# Loop para pegar as diferentes nomenclaturas para os simbolos dos genes no df
genesAML_new <- NULL
for (i in genesAML) {
  selected<- grep(pattern = i,x = all_cnvs_exp$SYMBOL ,value = T)
  genesAML_new <- c(genesAML_new, selected)
}

# Apenas unicos valores de genes
genesAML_new <-unique(genesAML_new)

# selecionando apenas os genes para o kruskal-walis test
inputKruskal <- all_cnvs_exp[all_cnvs_exp$SYMBOL %in% genesAML_new,]

# Loop

for (i in genesAML_new) {
  inputKruskal <- all_cnvs_exp[all_cnvs_exp$SYMBOL %in% i,]
  if (length(unique(all_cnvs_exp[all_cnvs_exp$SYMBOL %in% i,]$type))>1) {
    testeK       <- kruskal.test(x = inputKruskal$normalized_read_count,
                                 inputKruskal$type)

    assign(paste0("res_Kruskal_",i), data.frame(gene=i,
                                                statistic=testeK$statistic,
                                                p_value = testeK$p.value,
                                                method = testeK$method))
    }else{
      print(paste("The observation in some 'type' values only have one group:",i))
    }
}

resultsKruskal <- NULL
for (variable in grep(pattern = "res_K", value = T, ls())) {
  resultsKruskal <- rbind(resultsKruskal, get(variable))
  row.names(resultsKruskal) <-NULL
}

View(resultsKruskal[resultsKruskal$p_value <=0.05,]
)
