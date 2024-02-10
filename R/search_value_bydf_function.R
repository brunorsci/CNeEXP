# Comparar duas tabelas por uma coluna em comum e extrair as informcoes em uma unica tabela com mesclagem dos resultados

# uso: select_characters_from_two_df(tab_infos=info_amostras_artigo, col_infos=subject, tab_df=brca_contagens,col_df=bcr_patient_barcode )

select_characters_from_two_df= function(tab_infos,col_infos, tab_df, col_df ){
  selecionados=NULL
  for (i in 1:nrow(tab_df)) {
    tryCatch({
      temp=cbind(subset(tab_infos, unique(tab_infos[col_infos]) == tab_df[[col_df]][i]), tab_df[i,c(1:ncol(tab_df))])
      selecionados=rbind(selecionados,temp)

      stop("")
    }, error=function(e){})# Errors are ignored and no messages are not shown!
  }
  return(selecionados)

  rm(B,i)
}

