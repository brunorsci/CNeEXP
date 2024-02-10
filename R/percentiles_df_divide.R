percentiles_df_divide <- function(df, n_parts) {
  n_rows <- nrow(df)
  perc <- seq(0, 100, length.out = n_parts + 1)
  parts <- vector("list", n_parts)

  for (i in 1:n_parts) {
    start_row <- floor(perc[i] * n_rows / 100) + 1
    end_row <- floor(perc[i + 1] * n_rows / 100)
    parts[[i]] <- df[start_row:end_row, ]
  }

  return(parts)
}
