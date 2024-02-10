get_subtypes_in_tab<-function(exp){
  exp_new <- infoamostra[infoamostra$subject %in% as.character(exp),]
  exp_new <- as.data.frame(exp_new)
  return(exp_new)
}
