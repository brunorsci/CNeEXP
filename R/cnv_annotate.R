#' Annotate the GRanges with gene names
#'
#' This function takes a data frame object with detected Copy Number Variations (CNVs) and their ranges.
#' The function converts the data frame into a GRanges object to perform gene annotation for CNVs that overlap with gene ranges.
#' Optionally, it can use a GFF genome reference file downloaded from UCSC (http://genome.ucsc.edu/) by providing the `GFF_ref` argument,
#' or directly through UCSC by specifying the `ref_genome` argument with the common name of the reference genome.
#' It is important to specify the correct reference genome in order to accurately assign gene positions within the CNV ranges.
#'
#' @param input data frame. A data frame with GRanges of detected CNVs. The data frame is expected to have the following columns:
#' @param ref_genome string. The common name of the reference genome as used in UCSC (http://genome.ucsc.edu/). Default = "hg19". Examples: "hg19" and "hg38".
#' @param GFF_ref complete path. The directory and file name of the reference genome in GFF format as obtained from UCSC (http://genome.ucsc.edu/). Default = NULL.
#' @param organism string. The reference organism as specified in the Ensembl database. If set to NULL, gene name annotation will not be applied.
#' Instead, ENTREZ gene IDs will be annotated.#'   This is useful when organism data sets are not available in Ensembl and cannot be accessed through biomaRT. Default = "hsapiens_gene_ensembl".
#' @return A data frame object with annotated gene names for the overlapping CNVs.
#' @export

cnv_annotate <- function(input, ref_genome="hg19", GFF_ref=NULL, organism="hsapiens_gene_ensembl"){
  print("Getting started with gene annotation!")
  print("Note that a stable internet connection is required for the gene annotation process.")

  ###________________________________________________________________________###
  #    TO annotate THE SUPERPOSITION OBJECTS BETWEEN CNVs E GENES GRANGES        #
  ###------------------------------------------------------------------------###

  if (is.null(GFF_ref)== FALSE) {
    if (exists("txdb")==TRUE) {
      print("txdb object alredy exist...")
    }else{
      print("Gene annotation in CNV ranges with the provided GFF reference genome!")
      txdb <<- GenomicFeatures::makeTxDbFromGFF(GFF_ref,
                                               format="gtf",
                                               dataSource=NA,
                                               organism=NA,
                                               taxonomyId=NA,
                                               circ_seqs=NULL,
                                               chrominfo=NULL,
                                               miRBaseBuild=NA,
                                               metadata=NULL,
                                               dbxrefTag= NULL)
    }
  }else{
    if (exists("txdb")==TRUE) {
      print("txdb object alredy exist...")
      print("exclude the present txdb, if you want to build and use another one!")
    }else{
      print("Starting gene annotation in CNV ranges!")
      txdb <<- GenomicFeatures::makeTxDbFromUCSC(genome=ref_genome, tablename="knownGene",
                              transcript_ids=NULL,
                              circ_seqs=NULL,
                              url="http://genome.ucsc.edu/cgi-bin/",
                              goldenPath.url=getOption("UCSC.goldenPath.url"),
                              taxonomyId=NA,
                              miRBaseBuild=NA)
      }
    }

  # working on the ENTREZ IDS genes:
  if (exists("genes")==TRUE) {
    print("genes object, from txdb, alredy exist...")
  }else{
    genes <<- GenomicFeatures::genes(txdb)
  }

  #--- GENE OVERLAPING: ENTREZ GENE ID ANNOTATION---#
  # Find overlaps to assign gene identifiers to cnv regions: ENTREZ_ID
  input  <-GenomicRanges::GRanges(input)
  olaps  <- GenomicRanges::findOverlaps(genes, input, type="within")
  idx    <- factor(S4Vectors::subjectHits(olaps), levels=seq_len(S4Vectors::subjectLength(olaps)))

  input$entrez_id <- S4Vectors::splitAsList(genes$gene_id[S4Vectors::queryHits(olaps)], idx)


  #____________________________________________________________________________#
  #             ANNOTATE ENTREZ ID TO GENE NAMES USING biomaRt
  #----------------------------------------------------------------------------#

  # Check `organism` parameter to do or not to do de gene name annotation

  if (is.null(organism)) {
    print("The ``organism`` param is setted as ``NULL``: the gene names annotaion will not be apllied!")
  }else{
    print("Starting gene names annotation with biomaRT and ensembl...")
    print("This can take a while! Have a tea!")

    # Connect with biomaRT
    if (exists("mart")==TRUE) {
      print("biomaRt object alredy exist!...")
    }else{
      mart <<- biomaRt::useMart(biomart = "ensembl", dataset = organism)
    }

  # Get the list of entrez ids to annotate
  entrez_ids <- S4Vectors::splitAsList(genes$gene_id[S4Vectors::queryHits(olaps)], idx)
  #entrez_ids <- mcols(input)$ENTREZ_ID

  # Gene name annotation: with biomaRT by entrez IDs
  gene_name <- list()
    for (i in 1:length(entrez_ids)) {
      if (length(entrez_ids[[i]]) == 0) {
        gene_name[[i]] <- NA
      } else {
        h <- biomaRt::getBM(attributes = c("ensembl_gene_id", "external_gene_name"),
                   filters = "entrezgene_id",
                   values = unique(entrez_ids[[i]]),
                   mart = mart)
        gene_name[[i]] <- paste(h$external_gene_name, collapse = ", ")
      }
    }
  }

  # Add gene names to input
  input <- as.data.frame(input)
  input$gene_name <- unlist(gene_name)

  print("We are Done. Check the results!")
  return(input)
}
