#' DNA sequencing QC metrics
#'
#' @importFrom readr read_tsv
#' @importFrom dplyr bind_rows
#' @importFrom stringr str_match
#' @importFrom tibble as_tibble
#'
#'
#' @examples
#' x = target_dna_qc()
#' head(x)
#' colnames(x)
#' hist(x$Percentage_duplication)
#' hist(x$PCT_TARGET_BASES_20X)
#' hist(x$PCT_NEAR_BAIT + x$PCT_ON_BAIT)
#'
#' @export
target_dna_qc = function() {
  fnames = list.files(system.file('extdata', package='TargetOsteoAnalysis'), pattern = 'qcMetrics', full.names = TRUE)
  reslist = lapply(fnames,read_tsv)
  names(reslist) = c('discovery', 'valid_exome', 'valid_lcc', 'valid_roche')
  tmp = bind_rows(reslist, .id='dataset')
  df = as_tibble(str_match(tmp[['bamFile']],'(.*)_(.*)')[,2:3])
  colnames(df) = c('Sample', 'Type')
  bind_cols(df, tmp)
}
