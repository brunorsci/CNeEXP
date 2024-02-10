# Realizar pesquisa com org.Hs.eg.db

library(org.Hs.eg.db)

t=as.data.frame(unlist(strsplit(x = counts$Ensembl_ID, split = ".", fixed = TRUE)))
counts$Ensembl_ID=t[seq(from = 1, to = nrow(t), by = 2),]

columns(org.Hs.eg.db)
df=select(x = org.Hs.eg.db, keys=teste, keytype = "ENSEMBL", columns = "SYMBOL")



