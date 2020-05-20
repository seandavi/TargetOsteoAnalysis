#' Load ShatterSeq results
#'
#' @importFrom readr read_tsv
#'
#' @export
shatterseq_results = function() {
  read_tsv(system.file(package = 'TargetOsteoAnalysis', 'extdata/TargetOsteoDiscWGS.shatterseek.chromSummary.non-filtered.tsv.gz'))
}
