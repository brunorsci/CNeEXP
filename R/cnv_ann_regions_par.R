# Anotar Granges que se sobrepoem a regioes genicas do genoma de referencia: retornar os genes ids
# input com as regioes: cromossomos, start, end.
# Se atentar as nomenclaturas dos cromossomos, se apenas numerica "1" ou "chr1. Deve estar de acorodo 
# a nomenclatura encontrada no genoma de referencia utilizado.
# gtf_ref= genoma de referencia no formato gtf
# specie= especie de estudo com a nomenclatura cientifica.
cnv_ann_par<-function(input, gtf_ref=NULL, specie="Homo sapiens"){
  txdb <<- GenomicFeatures::makeTxDbFromGFF(gtf_ref,
                                            format="gtf",
                                            dataSource=NA,
                                            organism=specie,
                                            taxonomyId=NA,
                                            circ_seqs=NULL,
                                            chrominfo=NULL,
                                            miRBaseBuild=NA)
  gen <<- GenomicFeatures::genes(txdb)
  # Find overlaps to assign gene identifiers to cnv regions
  input  <-GenomicRanges::GRanges(input)
  olaps  <- GenomicRanges::findOverlaps(gen, input, type="within")
  idx    <- factor(S4Vectors::subjectHits(olaps), levels=seq_len(S4Vectors::subjectLength(olaps)))
  input$gene_ids <- S4Vectors::splitAsList(gen$gene_id[S4Vectors::queryHits(olaps)], idx)
  input=as.data.frame(input)
  return(input)
}