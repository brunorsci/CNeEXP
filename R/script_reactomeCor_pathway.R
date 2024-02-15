# Workflow: script para realizar a anotação de vias moleculares
# do cnvs selecionados e da correlação através de reactomePA

# Converter simbolos genicos para entrez ids
symbols_to_entrez_id<-function(input){
  library(org.Hs.eg.db) # mudar a forma de carregar essa library
  entrez_ids=NULL
  for (i in input) {
    x <-AnnotationDbi::select(x = org.Hs.eg.db, keys=i, keytype = "SYMBOL", columns = "ENTREZID")
    entrez_ids=rbind(entrez_ids, x)
  }

}

inputPosCor <- symbols_to_entrez_id(positive_correlations$gene)
inputPosCor

inputNegCor <- symbols_to_entrez_id(negative_correlations$gene)
inputNegCor

# ReactomePathway
reactomePositiveCorrelations <- enrichPathway(
  sort(na.omit(inputPosCor$ENTREZID)), ## espera entrez_id
  organism = "human",
  pvalueCutoff = 0.05,
  pAdjustMethod = "BH",
  qvalueCutoff = 0.2,
  #universe,
  minGSSize = 10,
  maxGSSize = 500,
  readable = FALSE
)

reactomeNegativeCorrelations <- enrichPathway(
  sort(na.omit(inputNegCor$ENTREZID)), ## espera entrez_id
  organism = "human",
  pvalueCutoff = 0.05,
  pAdjustMethod = "BH",
  qvalueCutoff = 0.2,
  #universe,
  minGSSize = 10,
  maxGSSize = 500,
  readable = FALSE
)

# Transformar em um data frame
reactomePositiveCorrelations <-as.data.frame(reactomePositiveCorrelations)
reactomeNegativeCorrelations <- as.data.frame(reactomeNegativeCorrelations)

# Visualização dos resultados
View(reactomePositiveCorrelations)
View(reactomeNegativeCorrelations)


