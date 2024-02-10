percentiles_df_divide_old <- function(df=teste, frac=10){
  perc <- NULL
  ## CALCULANDO OS PERCENTIS
  for (i in 1:as.numeric(frac)) {
    i <- i/frac
    perc <- c(perc , quantile(c(1:nrow(df)), probs =i))
  }
  ## DIVIDINDO O DATA FRAME EM PERCENTIS
  assign("perc_1", df[c(1:perc[1]), ], envir = .GlobalEnv)
  assign("perc_2", df[c((perc[1] + 1):perc[2]), ], envir = .GlobalEnv)
  assign("perc_3", df[c((perc[2] + 1):perc[3]), ], envir = .GlobalEnv)
  assign("perc_4", df[c((perc[3] + 1):perc[4]), ], envir = .GlobalEnv)
  assign("perc_5", df[c((perc[4] + 1):perc[5]), ], envir = .GlobalEnv)
  assign("perc_6", df[c((perc[5] + 1):perc[6]), ], envir = .GlobalEnv)
  assign("perc_7", df[c((perc[6] + 1):perc[7]), ], envir = .GlobalEnv)
  assign("perc_8", df[c((perc[7] + 1):perc[8]), ], envir = .GlobalEnv)
  assign("perc_9", df[c((perc[8] + 1):perc[9]), ], envir = .GlobalEnv)
  assign("perc_10", df[c((perc[9] + 1):perc[10]), ], envir = .GlobalEnv)
}
