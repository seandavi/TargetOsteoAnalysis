#' load stacked, filtered mutect calls
#'
#' @importFrom readr read_tsv
#'
#' @examples
#' head(variant_call)
#'
#' @export
variant_calls = function() {
  .variant_call_file = system.file(package='TargetOsteoAnalysis',
                                   'extdata/summary.TargetOsteo.mutect.GATKPlus.sampleInfo.geneLists.tab.gz')

  dat = readr::read_tsv(.variant_call_file)
  return(dat)
}
