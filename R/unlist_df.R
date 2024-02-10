df_unlist<-function(df, colname){
c<-null
 for (i in df[[colname]]) {
   un_ls<-unlist(i)
 }
  return(df)
}