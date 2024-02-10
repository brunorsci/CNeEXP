cnv_chr_change <- function(df, col, remove_X = FALSE, remove_Y = FALSE) {
  is_numeric <- grepl("^\\d+$", df[[col]])
  df[[col]] <- ifelse(is_numeric, paste0("chr", df[[col]]), df[[col]])

  df[[col]] <- ifelse(df[[col]] == "X", "chrX", df[[col]])
  df[[col]] <- ifelse(df[[col]] == "Y", "chrY", df[[col]])

  if (remove_X==TRUE) {
    df <- subset(df, df[[col]] != "chrX")
  }

  if (remove_Y==TRUE) {
    df <- subset(df, df[[col]] != "chrY")
  }
  # order the data frame by crom names
  df <- df[order(df[[col]]), ]

  return(df)
}
