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

# Selecionar cnvs para os genes KEGG map05221
selectedGenesCNVs <- all_cnvs_exp[all_cnvs_exp$SYMBOL %in% genesAML_new,]

# Selecionar correlações para os genes Definidos acima
selectedGenesCorrelation_Positive <- positive_correlations[positive_correlations$gene %in% genesAML_new,]
selectedGenesCorrelation_Negative <- negative_correlations[negative_correlations$gene %in% genesAML_new,]

View(selectedGenesCorrelation_Positive)
View(selectedGenesCorrelation_Negative)

# Selecionar apenas os CNVs
selectedGenesCNVs <- selectedGenesCNVs[selectedGenesCNVs$type != "neutral",]

# Criando uma tabela com a contagem
tableSelectedGenesCNVs <- as.data.frame(table(selectedGenesCNVs$SYMBOL))

