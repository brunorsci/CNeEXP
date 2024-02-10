#' Predict the change of Copy Number Variations: Gain or Loss
#'
#' This function calculates the direction of change of Copy Number Variations. It assumes that the `values`
#' are the log2(foldchanges) between the regions of segmentation of the imputed experiment.
#' Make sure that you have already calculated the logfoldchange of expected CNVs by any CNV calling algorithm.
#' This function returns only values reflecting the `Gain` or `Loss` of copy number based on the given cutoff
#' of logfoldchanges.It is not determine the magnitude of gain or loss of copies.
#'
#' @param value vector or collum with the values of log-foldchanges.
#' @param upper positive numeric value of upper threshold. Must be the value of the expect gain of copies where
#' logfoldchange above this will be set as a `Gain` of copies.  The value should be set close to the log2 of the
#'  expected foldchange for copy number 3 or 4 (log2(3/2)=0.5) as the results predict for cn.mops() algorithm. Default = 0.5.
#' @param lower negative numeric value of lower threshold.The value called below this will be called as `lower`.
#' The value should be set close to the log2 of the expected foldchange for copy number 1 or 0 (log2(1/2)= -1), as expected by cn.mops(). Default = -0.9
#' @param lim Limit for discriminate loss of one copy (heterozygous deletion) or 2 copies (homozygous deletion) of segment.
#' The log-fold change below this value will be marked as homozygous deletion (- 2 copies). Default= -2.
#' @return A vector with the `Gain`or `Loss`values of the expected log-fold changes.
#' @export
cnv_classify=function(value, upper= 0.5, lower=-0.9, lim= -2){
  cnvs <- NULL
  for (i in value) {
    if (i <= as.numeric(upper) & i >=as.numeric(lim)) {
      CN <- "Loss(-1)"
    }else(
      if (i < as.numeric(lim)) {
        CN <- "Loss(0)"
      }else(
        if(i >=as.numeric(upper)){
          CN <- "Gain"
        }
      )
    )
    cnvs=c(cnvs, CN)
  }
  return(cnvs)
}
