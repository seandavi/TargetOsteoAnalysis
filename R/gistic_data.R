
#' load TARGET GISTIC data as summarized experiment
#'
#' @import SummarizedExperiment
#' @importFrom readr read_tsv
#'
#' @examples
#' res = target_gistic_se()
#'
#' res
#'
#' head(colData(res))
#' assay(res,'cn')[1:5,1:5]
#'
#'
#' @export
target_gistic_se = function() {
  .gistic_file = system.file(package='TargetOsteoAnalysis','extdata/all_data_by_genes.txt.bz2')

  gistic = read_tsv(.gistic_file)
  mat = as.matrix(gistic[,4:ncol(gistic)])
  cdata = target_load_clinical()
  cdata = as.data.frame(cdata)
  cdata[[1]] = target_usi_to_samplename(cdata[[1]])
  rownames(cdata) = make.unique(cdata[[1]])
  cdata = cdata[colnames(mat),]
  fdata = gistic[,1:3]
  se = SummarizedExperiment::SummarizedExperiment(assays=list(cn = mat),
                                                  rowData = fdata,
                                                  colData = cdata)
  se
}
